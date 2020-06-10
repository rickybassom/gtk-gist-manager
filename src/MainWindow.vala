using ValaGist;

namespace GtkGistManager {

    public class MainWindow : Gtk.ApplicationWindow {
        private HeaderBar headerbar;
        private Gtk.Stack stack;
        private LoginManager login_manager;
        private MyProfile? my_profile;
        private MyProfileView? my_profile_view_inner;

        private LoadingView loading_view;
        private WelcomeView welcome_screen_view;
        private Gtk.Box my_profile_view;
        private Gtk.Box other_profile_view;

        public MainWindow(Gtk.Application application) {
            Object (
                application: application,
                icon_name: "com.github.rickybas.gtk-gist-manager",
                resizable: true,
                title: _("Gtk Gist Manager"),
                width_request: 1000,
                height_request: 600
            );
        }

        construct {
            // accounts
            my_profile = null;
            my_profile_view_inner = null;
            login_manager = new LoginManager ();

            // headerbar setup and actions
            headerbar = new HeaderBar(this);

            headerbar.refresh_clicked.connect (() => {
                switch_to_my_profile_view ();
            });

            headerbar.new_button_clicked.connect (() => {
                if (my_profile == null) {
                    Utils.log_warning ("Account details not entered");
                } else {
                    headerbar.open_new_gist_popover ();
                }
            });

            headerbar.new_gist.connect ((gist) => {
                if (my_profile == null) {
                    Utils.log_warning ("Account details not entered");
                } else {
                    my_profile.create (gist);
                }
            });

            headerbar.logout_clicked.connect (() => {
                Utils.store_token ("");
                switch_to_welcome_view ();
            });

            set_titlebar(headerbar);

            // all app views
            loading_view = new LoadingView ();
            welcome_screen_view = new WelcomeView (Utils.get_token ());
            my_profile_view = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            other_profile_view = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            welcome_screen_view.login_button_clicked.connect((token) => {
                if (!attempt_to_add_my_profile_view (token)) {
                    message("Login failed");
                } else {
                    Utils.store_token (token);
                }
            });

            // stack switches between views
            stack = new Gtk.Stack ();
            stack.add_named (my_profile_view, "my-profile");
            stack.add_named (other_profile_view, "other-profile");
            stack.add_named (welcome_screen_view, "welcome-screen");
            stack.add_named (loading_view, "loading");
            add (stack);

            stack.show_all ();

            // if stored details then go to profile view else login view
            attempt_to_add_my_profile_view (Utils.get_token ());

            // var settings = Gtk.Settings.get_default ();
            // settings.set_property ("gtk-application-prefer-dark-theme", true);

            show_all ();
        }

        public void open (GLib.File file) {
            print(file.get_basename ());
        }

        public void message(string text) {
            Utils.log_warning (text);
            var dialog = new Gtk.MessageDialog (
                this,
                0,
                Gtk.MessageType.INFO,
                Gtk.ButtonsType.OK,
                text
            );

            dialog.format_secondary_text (text);
            dialog.run ();

            dialog.destroy ();
        }

        public bool attempt_to_add_my_profile_view (string token) {
            if (token == ""){
                Utils.log_message ("No stored token");
                switch_to_welcome_view ();
                return false;
            }else{
                try {
                    my_profile = login_manager.login (token);
                }catch(ValaGist.Error e) {
                    message ("Could not login");
                    switch_to_welcome_view();
                    return false;
                }

                switch_to_my_profile_view ();
                return true;
            }
        }

        public void switch_to_my_profile_view () {
            headerbar.enable_headerbar_functions ();

            my_profile_view_inner = new MyProfileView(my_profile);
            my_profile_view.forall ((element) => my_profile_view.remove (element));
            my_profile_view.add (my_profile_view_inner.page_switcher);
            my_profile_view_inner.edited.connect(()=>{
                switch_to_my_profile_view ();
            });

            stack.set_visible_child (my_profile_view);

            if (my_profile == null) {
                Utils.log_warning ("Account details not entered");
            } else {
                Gist[] result = my_profile_view_inner.list_all();
                my_profile_view_inner.set_gists (result);
            }

            while(Gtk.events_pending()) {
                Gtk.main_iteration();
            }

            /*my_profile_view_inner.clicked.connect(()=>{
                my_profile_view_inner.page_switcher.sidebar.sidebar_list.sensitive = false;
            });

            my_profile_view_inner.unclicked.connect(()=>{
                my_profile_view_inner.page_switcher.sidebar.sidebar_list.sensitive = true;
            });*/
        }

        public void switch_to_other_profile_view () {
            headerbar.disable_headerbar_functions ();
            stack.set_visible_child (other_profile_view);
        }

        public void switch_to_welcome_view () {
            my_profile = null;
            headerbar.disable_headerbar_functions ();
            stack.set_visible_child (welcome_screen_view);
        }

        public void switch_to_loading_view () {
            stack.set_visible_child (loading_view);
        }

    }
}
    

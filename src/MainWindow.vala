using ValaGist;

namespace GtkGistManager {

    public class MainWindow : Gtk.ApplicationWindow {

        public static int width;
        public static int height;

        private HeaderBar headerbar;
        private Gtk.Stack stack;
        private LoginManager login_manager;
        private MyProfile? my_profile;
        private MyProfileView? my_profile_view_inner;

        private Gtk.Grid empty_view;
        private Gtk.Box message_view;
        private Gtk.Label message_label;
        private Gtk.Box my_profile_view;
        private Gtk.Box other_profile_view;

        public void open (GLib.File file) {
            print(file.get_basename ());
        }

        public MainWindow(Gtk.Application application) {
            Object (
                application: application,
                icon_name: "com.github.rickybas.gtk-gist-manager",
                resizable: true,
                title: _("Gtk Gist Manager"),
                width_request: 1200,
                height_request: 800
            );
        }

        construct {
            my_profile = null;
            my_profile_view_inner = null;

            login_manager = new LoginManager ();

            headerbar = new HeaderBar(this);

            headerbar.token_updated.connect ((token) => {
                try_to_add_my_profile_view (token);
            });

            headerbar.refresh_clicked.connect (() => {
                if (my_profile != null && my_profile_view_inner != null) {
                    my_profile_view_inner.load ();
                }
            });

            headerbar.new_button_clicked.connect (() => {
                if (my_profile != null) {
                    headerbar.open_new_gist_popover ();
                }
            });

            headerbar.new_gist.connect (() => {
                if (my_profile != null) {
                    // my_profile.create ();
                }
            });

            set_titlebar(headerbar);

            stack = new Gtk.Stack ();
            add (stack);

            empty_view = new Gtk.Grid ();

            message_view = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            message_view.halign = Gtk.Align.CENTER;

            message_label = new Gtk.Label ("");

            message_view.add (message_label);
            message_view.show_all ();

            my_profile_view = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            other_profile_view = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            stack.add_named (my_profile_view, "my-profile");
            stack.add_named (other_profile_view, "other-profile");
            stack.add_named (message_view, "message");
            stack.add_named (empty_view, "empty");

            stack.show_all ();
            stack.set_visible_child (empty_view);

            show_all ();

            try_to_add_my_profile_view (Utils.get_token ());
        }

        public void try_to_add_my_profile_view (string token) {
            if (token == ""){
                Utils.log_message ("No stored token");
                my_profile = null;
                switch_to_message_view ("No stored token");
                headerbar.disable_new_gists_button ();
                headerbar.open_settings_popover ();
            }else{
                try {
                    my_profile = login_manager.login (token);
                    my_profile_view_inner = new MyProfileView(my_profile);
                    my_profile_view.forall ((element) => my_profile_view.remove (element));
                    my_profile_view.add (my_profile_view_inner.page_switcher);

                    switch_to_my_profile_view ();
                    headerbar.enable_new_gists_button ();
                }catch(ValaGist.Error e) {
                    Utils.log_warning ("Could not login");
                    my_profile = null;
                    switch_to_message_view ("Could not login");
                    headerbar.disable_new_gists_button ();
                    headerbar.open_settings_popover ();
                }
            }
        }

        public void switch_to_my_profile_view () {
            stack.set_visible_child (my_profile_view);
            headerbar.current_view = "my-profile";
        }

        public void switch_to_other_profile_view () {
            // other_profile_view.add (other_profile_view_inner.page_switcher);
            stack.set_visible_child (other_profile_view);
            headerbar.current_view = "other-profile";
        }

        public void switch_to_message_view (string message) {
            message_label.label = message;
            stack.set_visible_child (message_view);
            headerbar.current_view = "message";
        }

        public void switch_to_empty_view () {
            stack.set_visible_child (empty_view);
            headerbar.current_view = "empty";
        }

    }
}
    

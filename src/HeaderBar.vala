namespace GtkGistManager {

    public class HeaderBar : Gtk.HeaderBar {

        private Gtk.SearchEntry search_bar;
        private Gtk.Grid search_grid;
        private Gtk.Popover search_pop;
        private Gtk.Button new_button;
        private Gtk.Button refresh_button;
        private Gtk.Button settings_button;
        private NewGistPopover new_gist_popover;
        private SettingsPopover settings_popover;

        public string current_view { get; set; }

        public signal void token_updated (string token);
        public signal void refresh_clicked ();
        public signal void new_button_clicked ();
        public signal void new_gist (string content);

        public HeaderBar (MainWindow window) {
            this.show_close_button = true;

            current_view = "empty";

            new_button = new Gtk.Button.with_label ("New");
            new_button.set_sensitive (false);

            new_gist_popover = new NewGistPopover (new_button);
            new_gist_popover.set_visible (false);
            new_gist_popover.create_gist.connect ((content) => {
                new_gist (content);
            });

            new_button.clicked.connect (() => {
                Utils.log_message ("New button clicked");
                new_button_clicked ();
            });

            settings_button = new Gtk.Button.from_icon_name ("open-menu-symbolic");

            settings_popover = new SettingsPopover (settings_button);
            settings_popover.set_visible (false);
            settings_popover.token_updated.connect ((token) => {
                Utils.store_token (token);
                token_updated (token);
            });

            settings_button.clicked.connect (() => {
                Utils.log_message ("Settings clicked");
                settings_popover.set_visible (true);
            });

            refresh_button = new Gtk.Button.from_icon_name ("view-refresh-symbolic");
            refresh_button.margin_start = 18;

            refresh_button.clicked.connect(() => {
                Utils.log_message ("Refresh clicked");
                refresh_clicked ();
            });

            search_bar = new Gtk.SearchEntry ();
            search_bar.set_placeholder_text ("Search");
            search_bar.width_chars = 50;

            this.set_custom_title (search_bar);

            search_grid = new Gtk.Grid ();
            search_grid.set_column_spacing (10);
            search_grid.set_margin_top (10);
            search_grid.set_margin_end (10);
            search_grid.set_margin_bottom (10);
            search_grid.set_margin_start (10);

            Gtk.Label search_label = new Gtk.Label ("Gist");
            search_grid.attach (search_label, 0, 0, 1, 1);

            search_grid.show_all ();

            search_pop = new Gtk.Popover (search_bar);
            search_pop.add (search_grid);

            search_bar.activate.connect ((e) => {
                search_pop.set_visible (true);
            });

            notify["current-view"].connect (() => {
                if (current_view == "my-profile") {
                    Utils.log_message ("headerbar my profile view");
                    refresh_button.set_sensitive (true);
                    search_bar.set_sensitive (true);
                } else if (current_view == "other-profile") {
                    Utils.log_message ("headerbar other profile view");
                    refresh_button.set_sensitive (true);
                    search_bar.set_sensitive (true);
                } else {
                    Utils.log_message ("headerbar empty view");
                    refresh_button.set_sensitive (false);
                    search_bar.set_sensitive (false);
                }
            });

            this.pack_start (new_button);
            this.pack_end (settings_button);
            this.pack_end (refresh_button);

            show_all ();

        }

        public void enable_new_gists_button () {
            new_button.set_sensitive (true);
        }

        public void disable_new_gists_button () {
            new_button.set_sensitive (false);
        }

        public void open_new_gist_popover () {
            new_gist_popover.set_visible (true);
        }

        public void open_settings_popover () {
            settings_popover.set_visible (true);
        }

        /*public void switch_to_profile_view (ProfileView profile) {
            refresh_button.clicked.connect (() => {
                Utils.log_message ("Refresh clicked");
                profile.load ();
            });

            search_bar.activate.connect ((e) => {
	            search_pop.set_visible (true);
            });

            if (profile.editable) {
                MyProfileView my_profile = (MyProfileView) profile;
                new_button = new Gtk.Button.with_label ("New");
                new_button.clicked.connect(() => {
                    var new_gist_popover = new NewGistPopover (new_button);
                    new_gist_popover.token_updated.connect ((token) => {
                        my_profile.create ();
                    });
                    new_gist_popover.set_visible (true);
                });
                this.pack_start (new_button);
            }
        }*/

    }

}

namespace GtkGistManager {

    public class HeaderBar : Gtk.HeaderBar {

        private Gtk.SearchEntry search_bar;
        private Gtk.Grid search_grid;
        private Gtk.Popover search_pop;
        private Gtk.Button new_button;
        private Gtk.Button refresh_button;
        private Gtk.Button web_button;
        private Gtk.Button logout_button;
        private NewGistPopover new_gist_popover;

        public signal void refresh_clicked ();
        public signal void logout_clicked ();
        public signal void new_button_clicked ();
        public signal void new_gist (ValaGist.Gist new_gist);
        public signal void failed_edit (string message);

        public HeaderBar (MainWindow window) {
            this.show_close_button = true;

            new_button = new Gtk.Button.with_label ("New");
            new_button.set_sensitive (false);

            new_gist_popover = new NewGistPopover (new_button);
            new_gist_popover.set_visible (false);
            new_gist_popover.create_gist.connect ((source, gist) => {
                new_gist (gist);
            });
            new_gist_popover.failed_edit.connect ((source, message) => {
                failed_edit (message);
            });

            new_button.clicked.connect (() => {
                Utils.log_message ("New button clicked");
                new_button_clicked ();
            });

            refresh_button = new Gtk.Button.from_icon_name ("view-refresh-symbolic");
            refresh_button.margin_start = 18;
            refresh_button.get_style_context().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            refresh_button.clicked.connect(() => {
                Utils.log_message ("Refresh clicked");
                refresh_clicked ();
            });

            web_button = new Gtk.Button.with_label ("Web");
            web_button.set_sensitive (false);
            web_button.clicked.connect(() =>{
                Gtk.show_uri_on_window(null, "https://gist.github.com",
                                   Gdk.CURRENT_TIME);
            });

            search_bar = new Gtk.SearchEntry ();
            search_bar.set_placeholder_text ("Search");
            search_bar.width_chars = 50;

            logout_button = new Gtk.Button.with_label ("Logout");
            logout_button.margin_start = 18;
            logout_button.get_style_context().add_class(Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

            logout_button.clicked.connect(() => {
                Utils.log_message ("Logout clicked");
                logout_clicked ();
            });

            // this.set_custom_title (search_bar);

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

            this.pack_start (new_button);
            this.pack_end (logout_button);
            this.pack_end (web_button);
            this.pack_end (refresh_button);

            show_all ();

        }

        public void disable_headerbar_functions () {
            new_button.set_sensitive (false);
            search_bar.set_sensitive (false);
            refresh_button.set_sensitive (false);
            logout_button.set_sensitive (false);
            web_button.set_sensitive (false);
        }

        public void enable_headerbar_functions () {
            new_button.set_sensitive (true);
            search_bar.set_sensitive (true);
            refresh_button.set_sensitive (true);
            logout_button.set_sensitive (true);
            web_button.set_sensitive (true);
        }

        public void open_new_gist_popover () {
            new_gist_popover.set_visible (true);
        }

    }

}

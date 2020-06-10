class WelcomeView : Gtk.Box {

    private Gtk.Entry token_entry;
    private Gtk.Button login_button;
    private Gtk.Button help_button;

    public signal void login_button_clicked (string token);

    public WelcomeView (string token) {
        this.set_orientation(Gtk.Orientation.VERTICAL);
        this.margin = 15;

        token_entry = new Gtk.Entry();
        token_entry.margin = 10;
        token_entry.set_placeholder_text("Token");
        token_entry.set_text (token);

        login_button = new Gtk.Button.with_label("Login");
        login_button.margin = 10;
        login_button.get_style_context().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        login_button.clicked.connect(() =>{
            login_button_clicked (token_entry.get_text());
        });

        help_button = new Gtk.Button.with_label("How to generate a token");
        help_button.margin = 10;
        help_button.clicked.connect(() =>{
            Gtk.show_uri_on_window(null, "https://github.com/rickybas/gtk-gist-manager/wiki/How-to-generate-a-token-for-gtk-gist-manager",
                           Gdk.CURRENT_TIME);
        });

        var title = new Gtk.Label("<b>Enter GitHub token</b>");
        title.set_use_markup (true);
        title.margin = 50;

        pack_start(title, false, false);
        pack_start(token_entry, false, false);
        pack_start(login_button, false, false);
        pack_start(help_button, false, false);
        login_button.grab_focus ();
    }
}

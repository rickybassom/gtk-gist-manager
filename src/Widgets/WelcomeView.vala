class WelcomeView : Gtk.Box {

    private Gtk.Entry token_entry;
    private Gtk.Button login_button;

    public signal void login_button_clicked (string token);

    public WelcomeView() {
        this.set_orientation(Gtk.Orientation.VERTICAL);
        this.margin = 15;

        token_entry = new Gtk.Entry();
        login_button = new Gtk.Button.with_label("Login");
        login_button.clicked.connect(() =>{
            login_button_clicked (token_entry.get_text());
        });

        pack_start(new Gtk.Label("Login Screen"), false, false);
        pack_start(token_entry, false, false);
        pack_start(login_button, false, false);
    }
}

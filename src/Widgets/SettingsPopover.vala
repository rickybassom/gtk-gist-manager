namespace GtkGistManager {

	public class SettingsPopover : Gtk.Popover {
        private Gtk.Box layout_box;
        private Gtk.Entry token_input;
        private Gtk.Button confirm_button;

        public signal void token_updated (string token);

        public SettingsPopover (Gtk.Widget widget) {
            Object (relative_to: widget);

            layout_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 6);
            token_input = new Gtk.Entry();
            confirm_button = new Gtk.Button.with_label("Update token");
            layout_box.margin = 12;

            token_input.editable = true;
            token_input.set_placeholder_text("Token");
            token_input.activate.connect(() => {
                token_updated(token_input.get_text());
                token_input.set_text("");
                this.hide();
            });

            confirm_button.clicked.connect(() => {
                token_updated(token_input.get_text());
                token_input.set_text("");
                this.hide();
            });

            Gtk.Separator separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);

            layout_box.pack_start(token_input);
            layout_box.pack_start(confirm_button);
            layout_box.pack_start (separator, true, true, 0);

            this.child = layout_box;
            show_all ();
        }
	}
}

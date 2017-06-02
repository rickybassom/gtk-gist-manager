namespace GtkGistManager {

	public class NewGistPopover : Gtk.Popover {
        private Gtk.Box layout_box;
        private Gtk.Entry content_input;
        private Gtk.Button confirm_button;

        public signal void create_gist (string content);

        public NewGistPopover (Gtk.Widget widget) {
            Object (relative_to: widget);

            layout_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 6);
            content_input = new Gtk.Entry();
            confirm_button = new Gtk.Button.with_label("Create new gist");
            layout_box.margin = 12;

            content_input.editable = true;
            content_input.set_placeholder_text("Gist");
            content_input.activate.connect(() => {
                create_gist(content_input.get_text());
                content_input.set_text("");
                this.hide();
            });

            confirm_button.clicked.connect(() => {
                create_gist(content_input.get_text());
                content_input.set_text("");
                this.hide();
            });

            Gtk.Separator separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);

            layout_box.pack_start(content_input);
            layout_box.pack_start(confirm_button);
            layout_box.pack_start (separator, true, true, 0);

            this.child = layout_box;
            show_all ();
        }
	}
}

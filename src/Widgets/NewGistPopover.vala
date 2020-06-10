namespace GtkGistManager {

	public class NewGistPopover : Gtk.Popover {
        private Gtk.Box layout_box;
        private Gtk.Entry description_input;
        private Gtk.Button confirm_button;
        private Gtk.Button add_file_button;
        private GistView new_gist_wid;

        public signal void create_gist (ValaGist.Gist new_gist);

        public NewGistPopover (Gtk.Widget widget) {
            Object (relative_to: widget);

            set_size_request (500, 500);

            layout_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 6);
            layout_box.margin = 12;

            Gtk.Separator separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);

            refresh ();

            layout_box.pack_start (separator, false, false, 0);
            layout_box.pack_start(confirm_button, false, false, 0);

            this.child = layout_box;
            show_all ();
        }

        public void refresh () {
            ValaGist.Gist new_gist = new ValaGist.Gist ("asdas", false, {new ValaGist.GistFile("file_name.txt", "123456")});
            new_gist_wid = new GistView(new_gist, true);
            new_gist_wid.toggle_is_editable ();
            new_gist_wid.edited.connect((gist) => {
                create_gist(gist);
                this.hide();
            });
            layout_box.pack_start (new_gist_wid, true, true, 0);
        }
	}
}

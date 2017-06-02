namespace GtkGistManager {

    public class SidebarList : Gtk.Box {
		public Gtk.ScrolledWindow scrolled_window;
		public Gtk.ListBox list_box;

		public SidebarList() {
			set_vexpand(true);

			scrolled_window = new Gtk.ScrolledWindow(null, null);
			scrolled_window.width_request = 180;
			add (scrolled_window);

			list_box = new Gtk.ListBox();
			list_box.set_selection_mode(Gtk.SelectionMode.SINGLE);
			scrolled_window.add(list_box);
		}

		public SidebarTabRow add_row (string name) {
		    SidebarTabRow row = new SidebarTabRow(name);
		    list_box.add(row);
		    return row;
		}
	}

	public class SidebarTabRow : Gtk.Box {
		public string title;

		public Gtk.Image icon;
		public Gtk.Label label;

		public SidebarTabRow (string title) {
			this.title = title;
			this.height_request = 40;

			this.set_orientation(Gtk.Orientation.HORIZONTAL);
			this.set_margin_start(8);
			this.set_margin_end(8);
			this.set_spacing(4);
			this.set_tooltip_text(this.title);

			this.icon = new Gtk.Image();
			this.icon.set_from_icon_name("text-x-generic-symbolic", Gtk.IconSize.MENU);
			this.add(this.icon);

			this.label = new Gtk.Label(title);
			this.label.set_ellipsize(Pango.EllipsizeMode.END);
			this.add(this.label);

			this.show_all();
		}

	}

}

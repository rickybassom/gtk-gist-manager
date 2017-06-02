namespace GtkGistManager {
	public class Sidebar : Gtk.Stack {
		public SidebarList sidebar_list;

		public Sidebar() {
			width_request = 150;

			sidebar_list = new SidebarList();

			add(sidebar_list);
		}

		public SidebarTabRow add_row (string title) {
		    return sidebar_list.add_row (title);
		}
	}
}

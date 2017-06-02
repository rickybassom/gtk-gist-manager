namespace GtkGistManager {
	public class PageSwitcher : Gtk.Box {

		public Sidebar sidebar;
		public Gtk.Stack pages;

	    public PageSwitcher () {
	        Object(orientation: Gtk.Orientation.HORIZONTAL,
	               spacing: 0);
	    }

	    construct {
			sidebar = new Sidebar();
			add(this.sidebar);

			pages = new Gtk.Stack();
			pages.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);
			add(this.pages);
	    }

	    public void add_page (Gtk.Widget page, string title, string name) {
	        pages.add_titled (page, name, title);

		    var row_widget = sidebar.add_row (title);

		    sidebar.sidebar_list.list_box.row_selected.connect((row_selected) => {
	            if (row_selected.get_child() == row_widget) {
	                pages.set_visible_child_name (name);
	            }
	        });
	    }

	    public void remove_all () {
	        pages.forall ((element) => pages.remove (element));
	        sidebar.sidebar_list.list_box.forall ((element) => sidebar.sidebar_list.list_box.remove (element));
	    }

	}
}

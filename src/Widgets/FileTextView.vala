namespace GtkGistManager {

	public class FileTextView : Gtk.Bin {

		private Gtk.SourceView source_view;
		private Gtk.SourceBuffer source_buffer;
		private Gtk.SourceLanguageManager source_manager;
		private Gtk.SourceLanguage language;
		private string text;

		public FileTextView(string file_text){
			source_manager = Gtk.SourceLanguageManager.get_default();
	        source_view = new Gtk.SourceView ();
	        source_buffer = (Gtk.SourceBuffer) source_view.buffer;
	        set_text(file_text);

	        source_view.editable = false;

	        source_view.left_margin = 5;
	        source_view.show_line_numbers = true;

	        Gtk.ScrolledWindow scroll_gist = new Gtk.ScrolledWindow(null, null);
	        scroll_gist.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.NEVER);
	        scroll_gist.add(source_view);

	        this.add(scroll_gist);
		}

		public string get_text(){
		    Gtk.TextIter start;
            Gtk.TextIter end;

            this.source_buffer.get_start_iter (out start);
            this.source_buffer.get_end_iter (out end);
			return source_buffer.get_text(start, end, false);
		}

		public void set_text(string text){
		    this.text = text;
			source_buffer.set_text(text);
		}

		public string get_syntax(){
		    return source_buffer.language.get_name();
		}

		public void set_syntax(string filename){
			language = source_manager.guess_language(filename, null);
			source_buffer.set_language(language);
		}

		public bool get_editable(){
		    return source_view.editable;
		}

		public void toggle_editable(){
		    source_view.editable = !source_view.editable;
		}
	}
}

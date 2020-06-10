using ValaGist;

namespace GtkGistManager {

    class FileView : Gtk.Box{

        public GistFile file;
        public FileTextView file_text_view;
        private string file_name;
        private Gtk.Label name_entry;

        public FileView(GistFile file) { //change to Gist object
            this.file = file;
            this.set_orientation(Gtk.Orientation.VERTICAL);
            this.margin = 15;

            set_name(file.filename);

            file_text_view = new FileTextView("");
            file_text_view.set_syntax(file.filename);
            this.pack_end(file_text_view, true);

            name_entry = new Gtk.Label("");
            name_entry.margin_bottom = 5;
            name_entry.set_markup("<b>" + get_name() + "</b>");
            this.pack_start(name_entry, false);
        }

        public string get_name(){
            return file_name;
        }

        public void set_name(string name){
            this.file_name = name;
        }

        public bool get_editable(){
		    return file_text_view.get_editable();
		}

		public void toggle_editable(){
		    file_text_view.toggle_editable();
		}

		public string get_content(){
            return file_text_view.get_text();
        }

        public void load_content(){
            new GLib.Thread<void*>("file-processor", () => {
                file_text_view.set_text(file.get_content(true));
                return null;
            });
        }

    }

}

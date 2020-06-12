using ValaGist;

namespace GtkGistManager {

    class FileView : Gtk.Box{

        public GistFile file;
        public FileTextView file_text_view;
        private Gtk.Entry name_entry;

        public FileView(GistFile file) { //change to Gist object
            this.file = file;
            this.set_orientation(Gtk.Orientation.VERTICAL);
            this.margin = 15;

            file_text_view = new FileTextView("");
            file_text_view.set_syntax(file.filename);
            this.pack_end(file_text_view, true);

            name_entry = new Gtk.Entry();
            name_entry.set_text (file.filename);
            name_entry.editable = false;
            name_entry.margin_bottom = 5;
            this.pack_start(name_entry, false);
        }

        public string get_name(){
            print (name_entry.get_text ());
            return name_entry.get_text ();
        }

        public bool get_editable(){
		    return file_text_view.get_editable();
		}

		public void toggle_editable(){
		    file_text_view.toggle_editable();
		    name_entry.editable = !name_entry.editable;
		}

		public string get_content(){
            return file_text_view.get_text();
        }

        public void load_content(){
            /*new GLib.Thread<void*>("file-processor", () => {
                var a = file.get_content (true);
                file_text_view.set_text (a);
                return null;
            });*/
            var a = file.get_content (true);
            file_text_view.set_text (a);
        }

    }

}

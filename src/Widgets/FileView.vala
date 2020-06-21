using ValaGist;

namespace GtkGistManager {

    class FileView : Gtk.Box{

        public GistFile file;
        public FileTextView file_text_view;
        private Gtk.Entry name_entry;

        public string orginal_filename;
        public string orginal_content;

        public FileView(GistFile file) { //change to Gist object
            this.file = file;
            this.set_orientation(Gtk.Orientation.VERTICAL);
            this.margin = 15;

            file_text_view = new FileTextView("");
            file_text_view.set_syntax(file.filename);
            this.pack_end(file_text_view, true);

            name_entry = new Gtk.Entry();
            name_entry.get_style_context ().add_class ("filenameentry");
            name_entry.set_text (file.filename);
            name_entry.editable = false;
            name_entry.can_focus = false;
            name_entry.margin_bottom = 5;
            this.pack_start(name_entry, false);

            orginal_filename = file.filename;

            orginal_filename = file.filename;
            orginal_content = null;
        }

        public void reset() {
            name_entry.set_text (orginal_filename);
            print ("herrrrrrrrrr");
            if (orginal_content != null) {
                print ("here---------------------" + orginal_content);
                file_text_view.set_text (orginal_content);
            }
        }

        public string get_name(){
            return name_entry.get_text ();
        }

        public bool get_editable(){
		    return file_text_view.get_editable();
		}

		public void toggle_editable(){
		    file_text_view.toggle_editable();
		    name_entry.editable = !name_entry.editable;
		    name_entry.can_focus = !name_entry.can_focus;
		}

		public string get_content(){
		    string file_content = file_text_view.get_text();
            return file_content;
        }

        public void load_content(){
            new GLib.Thread<void*>("load-contents", () => {
                var a = file.get_content (true);
                Idle.add (()=>{
                    if (orginal_content == null) {
		                orginal_content = a;
		            }
                    file_text_view.set_text (a);
                    return false;
                });
                return null;
            });
        }

    }

}

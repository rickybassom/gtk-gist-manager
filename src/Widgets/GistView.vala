namespace GtkGistManager {

    class GistView : Gtk.Box{

        public ValaGist.Gist gist;
        public FileView[] file_view = {};

        private bool is_editable;
        public signal void edited (ValaGist.Gist gist);
        private Gtk.ScrolledWindow scroll_files;
        private Gtk.Box scroll_files_box;
        private Gtk.ActionBar action_bar;
        private Gtk.Button edit_button;
        private Gtk.CheckButton public_check;
        private Gtk.Entry description_entry;
        private Gtk.MenuButton gist_options_button;

        public GistView (ValaGist.Gist gist, bool can_edit) {
            this.gist = gist;
            this.set_orientation(Gtk.Orientation.VERTICAL);

            if (can_edit){
                edit_button = new Gtk.Button.with_label("Edit");
                edit_button.get_style_context().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                edit_button.clicked.connect(() =>{
                    toggle_is_editable();
                });
            }


            public_check = new Gtk.CheckButton.with_label("Public");
            public_check.active = gist.is_public;
            public_check.set_sensitive(false);

            description_entry = new Gtk.Entry();
            description_entry.set_placeholder_text("Description");
            description_entry.set_hexpand(true);
            description_entry.set_editable(false);
            description_entry.set_text(gist.description);

            gist_options_button = new Gtk.MenuButton();

            action_bar = new Gtk.ActionBar();
            if (can_edit) action_bar.pack_start(edit_button);
            action_bar.pack_end(gist_options_button);
            action_bar.pack_end(public_check);
            action_bar.pack_end(description_entry);

            scroll_files = new Gtk.ScrolledWindow(null, null);
            scroll_files_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            scroll_files.add(scroll_files_box);

            set_files(gist);
            this.pack_start(scroll_files, true);
            this.pack_end(action_bar, false);
        }

        public bool get_is_editable(){
            return is_editable;
        }

        public void toggle_is_editable(){
            is_editable = !is_editable;
            if(is_editable){
                description_entry.set_editable(true);
                public_check.set_sensitive(true);
                foreach(FileView file in file_view){
                    file.toggle_editable();
                }
                edit_button.set_label("Save");
                edit_button.get_style_context().remove_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                edit_button.get_style_context().add_class(Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);

            }else{
                description_entry.set_editable(false);
                public_check.set_sensitive(false);
                foreach(FileView file in file_view){
                    file.toggle_editable();
                }
                edit_button.set_label("Edit");
                edit_button.get_style_context().remove_class(Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
                edit_button.get_style_context().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                gist.edit_description(get_description());
                //gist.is_public = get_is_public();
                int count = 0;
                foreach(FileView file_v in file_view){
                    print(file_v.get_content());
                    gist.files[count].edit_file_content(file_v.get_content());
                    count+=1;
                }
                edited(gist);

            }

        }

        public string get_description(){
            return description_entry.get_text();
        }

        public void set_description(string description){
            description_entry.set_text(description);
        }

        /*
        public bool get_is_public(){
            return public_check.get_mode();
        }

        public void set_is_public(bool is_public){
            public_check.set_mode(is_public);
        }
        */

        private void set_files(ValaGist.Gist gist){
            foreach(ValaGist.GistFile file in gist.files){
                file_view += new FileView(file);
                scroll_files_box.pack_start(file_view[file_view.length - 1]);
            }
        }

    }

}

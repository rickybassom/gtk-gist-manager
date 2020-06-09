using ValaGist;

namespace GtkGistManager {

    public class OtherProfileView : ProfileView, Object {

        public Gist[] gists { get; set; }
        public bool editable { get; set; }

        public PageSwitcher page_switcher { get; set; }

        public OtherProfile profile;
        public bool first;

        public OtherProfileView(OtherProfile profile){
            this.profile = profile;
            editable = false;
            first = true;

            page_switcher = new PageSwitcher ();
            page_switcher.show_all ();
        }

        public async Gist[] list_all () {
            return null;
        }

        public void set_gists(Gist[] gists){
            page_switcher.remove_all ();
	        set_gists_widgets(gists);
        }

        private void set_gists_widgets(Gist[] gists){
            foreach(Gist gist in gists){
                var gist_view = new GistView(gist, false);

                page_switcher.add_page (gist_view, gist.name, gist.id);

                page_switcher.pages.notify["visible-child-name"].connect ((sender, property) => {
                    if (gist.id == page_switcher.pages.get_visible_child_name ()) {
                        GistView wid = (GistView) page_switcher.pages.get_child_by_name(gist.id);
                        foreach(FileView file_v in wid.file_view){
                            file_v.load_content();
                        }
                    }
                });
            }
        }

    }

}

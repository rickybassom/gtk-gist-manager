using ValaGist;

namespace GtkGistManager {

    public interface ProfileView : Object {

        public abstract Gist[] gists { get; set; }
        public abstract bool editable{ get; set; }
        public abstract Gist[] list_all();

        public abstract PageSwitcher page_switcher { get; set; }
    }

}

using ValaGist;

namespace GtkGistManager {

    public interface ProfileView : Object {

        public abstract Gist[] gists { get; set; }
        public abstract bool editable{ get; set; }
        public abstract void load();

        public abstract PageSwitcher page_switcher { get; set; }
    }

}

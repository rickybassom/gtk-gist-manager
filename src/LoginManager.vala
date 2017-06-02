using ValaGist;

namespace GtkGistManager {

    public class LoginManager : Object {

        public MyProfile login (string token) throws ValaGist.Error {
            MyProfile profile = new MyProfile (token);
            return profile;
        }

    }

}

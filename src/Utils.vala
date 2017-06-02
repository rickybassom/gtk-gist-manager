namespace GtkGistManager {

    public class Utils {

        public static void store_token (string token) {
            var settings = new Settings ("com.github.rickybas.gtk-gist-manager");
            settings.set_string ("token", token);
        }

        public static string get_token () {
            var settings = new Settings ("com.github.rickybas.gtk-gist-manager");
            return settings.get_string ("token");
        }

        public static void log_message (string message) {
            GLib.log ("com.github.rickybas.gtk-gist-manager", GLib.LogLevelFlags.LEVEL_MESSAGE, message );
        }

        public static void log_warning (string message) {
            GLib.log ("com.github.rickybas.gtk-gist-manager", GLib.LogLevelFlags.LEVEL_WARNING, message );
        }

        public static void log_error (string message) {
            GLib.log ("com.github.rickybas.gtk-gist-manager", GLib.LogLevelFlags.LEVEL_ERROR, message );
        }
    }

}

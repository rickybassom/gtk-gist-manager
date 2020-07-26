/*
* Copyright (c) 2011-2015 APP Developers (http://launchpad.net/APP)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
* Boston, MA 02111-1307, USA.
*
* Authored by: Ricky Bassom
*/

namespace GtkGistManager {

    public class Application : Gtk.Application {

        private MainWindow window;

        public Application() {
            Object(application_id: APP_ID,
                    flags: ApplicationFlags.FLAGS_NONE);
        }

        protected override void activate() {
            window = new MainWindow(this);

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("com/github/rickybassom/gtk-gist-manager/Application.css");
            print (provider.to_string());
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        }

        public static int main(string[] args) {
            Application app = new Application();
            return app.run(args);
        }
    }
}
    

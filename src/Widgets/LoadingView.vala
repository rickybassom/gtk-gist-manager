class LoadingView : Gtk.Box {

    Gtk.Spinner spinner;

    public LoadingView() {
        this.set_orientation(Gtk.Orientation.VERTICAL);
        this.margin = 15;

        spinner = new Gtk.Spinner();
        spinner.start();

        pack_start(spinner, false, false);
    }
}

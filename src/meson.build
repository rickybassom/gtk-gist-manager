sources = files(
    'HeaderBar.vala',
    'Application.vala',
    'Constants.vala',
    'MainWindow.vala',
    'LoginManager.vala',
    'Utils.vala',
    'Widgets/WelcomeView.vala',
    'Widgets/FileTextView.vala',
    'Widgets/FileView.vala',
    'Widgets/GistView.vala',
    'Widgets/ProfileView.vala',
    'Widgets/MyProfileView.vala',
    'Widgets/OtherProfileView.vala',
    'Widgets/LoadingView.vala',
    'Widgets/NewGistPopover.vala',
    'Widgets/PageSwitcher/PageSwitcher.vala',
    'Widgets/PageSwitcher/Sidebar.vala',
    'Widgets/PageSwitcher/SidebarList.vala'
)

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h'
]

cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required : false)

executable(meson.project_name(),
           sources,
           asresources,
           c_args: c_args,
           dependencies: [glib, gobject, gio, gtk, gtksourceview, libsecret, valagist, m_dep],
           install: true)

meson.add_install_script('../meson/post_install.py')

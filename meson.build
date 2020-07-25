project('com.github.rickybassom.gtk-gist-manager', ['vala', 'c'],
        version: '0.1',
        license: 'GNU')

gnome = import('gnome')
i18n = import('i18n')

asresources = gnome.compile_resources(
    'as-resources', 'data/css.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

glib = dependency('glib-2.0', version: '>=2.32')
gobject = dependency('gobject-2.0', version: '>=2.32')
gio = dependency('gio-2.0', version: '>=2.32')
gtk = dependency('gtk+-3.0')
gtksourceview = dependency('gtksourceview-3.0')
libsecret = dependency('libsecret-1')

valagist_proj = subproject('vala-gist')
valagist = valagist_proj.get_variable('valagist_dep')

deps = [
    glib,
    gobject,
    gio,
    gtk,
    gtksourceview,
    libsecret,
    valagist
]

subdir('src')
subdir('data')

meson.add_install_script('meson/post_install.py')


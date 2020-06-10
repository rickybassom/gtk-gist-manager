project('com.github.rickybas.gtk-gist-manager', ['vala', 'c'],
        version: '0.1',
        license: 'GNU')

version = '1.0'

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
gtksourceview = dependency('gtksourceview-3.0', version: '>=3.10')
libsecret = dependency('libsecret-1')

valagist = dependency('valagist-1.0')

subdir('src')
subdir('data')

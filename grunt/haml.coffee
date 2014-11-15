module.exports = (grunt) ->
  views:
    files: grunt.file.expandMapping([
      'app/**/*.haml'
      'app/partials/**/*.html.haml'
    ],
    '',
      rename: (base, path) -> path.replace(/\.haml$/, '')
    )
  options:
    language: 'coffee'
    pathRelativeTo: '<%= yeoman.app %>'

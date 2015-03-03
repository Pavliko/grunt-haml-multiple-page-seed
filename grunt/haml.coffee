module.exports = (grunt) ->
  views:
    files: grunt.file.expandMapping([
      'app/**/*.haml'
    ],
    '',
      rename: (base, path) -> path.replace(/\.haml$/, '')
    )
  options:
    language: 'coffee'
    pathRelativeTo: '<%= yeoman.app %>'

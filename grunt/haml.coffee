module.exports = (grunt) ->
  views:
    files: grunt.file.expandMapping(['app/views/*.haml'], '', rename: (base, path) -> path.replace(/\.haml$/, ''))

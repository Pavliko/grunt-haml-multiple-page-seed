module.exports =
  options:
    port: 9090
    hostname: 'localhost'
    livereload: 35729
  livereload:
    options:
      open: true
      middleware: (connect) ->
        [
          connect.static('.tmp')
          connect().use '/bower_components', connect.static('./bower_components')
          connect.static('app')
        ]
  dist:
    options:
      open: true
      base: '<%= yeoman.dist %>'

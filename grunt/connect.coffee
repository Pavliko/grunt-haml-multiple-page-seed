module.exports =
  options:
    port: 3098
    hostname: 'localhost'
    livereload: 35735
  livereload:
    options:
      open:
        target: 'http://static.local'
        appName: 'Google Chrome'
      middleware: (connect) ->
        [
          connect.static('.tmp')
          connect().use '/bower_components', connect.static('./bower_components')
          connect.static('app')
        ]
  dist:
    options:
      open:
        target: 'http://static.local'
        appName: 'Google Chrome'
      base: '<%= yeoman.dist %>'

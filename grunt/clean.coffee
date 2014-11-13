module.exports =
  dist:
    files: [
        dot: true
        src: [
          '.tmp'
          '<%= yeoman.dist %>/{,*/}*'
          'app/contents/*.html'
          '!<%= yeoman.dist %>/.git*'
        ]
    ]
  server: '.tmp'

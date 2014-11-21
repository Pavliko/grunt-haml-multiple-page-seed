module.exports =
  dist:
    files: [
        dot: true
        src: [
          '.tmp'
          '<%= yeoman.dist %>/{,*/}*'
          '<%= yeoman.app %>/contents/**/*.html'
          '!<%= yeoman.dist %>/.git*'
        ]
    ]
    options:
      force: true
  server: '.tmp'

module.exports =
  app:
    src: ['<%= yeoman.app %>/index.html']
    ignorePath: /\.\.\//
  sass:
    src: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}']
  js:
    src: ['<%= yeoman.app %>/index.html']
    ignorePath: /\.\.\//
  options:
    cwd: '<%= yeoman.app %>'

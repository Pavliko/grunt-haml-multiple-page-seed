module.exports =
  app:
    src: ['<%= yeoman.app %>/index.html']
  sass:
    src: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}']
  js:
    src: ['<%= yeoman.app %>/index.html']
  options:
    cwd: '<%= yeoman.app %>'

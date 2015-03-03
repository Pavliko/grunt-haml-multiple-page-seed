module.exports =
  options:
    livereload: '<%= connect.options.livereload %>'
  bower:
    files: ['<%= yeoman.app %>/bower.json']
    tasks: ['wiredep']
  coffee:
    files: ['<%= yeoman.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}']
    tasks: ['newer:coffee:dist']
  styles:
    files: ['<%= yeoman.app %>/styles/{,*/}*.scss']
    tasks: ['libsass', 'newer:copy:styles', 'autoprefixer']
  haml:
    files: ['<%= yeoman.app %>/**/*.haml', '<%= yeoman.app %>/index.html']
    tasks: ['haml', 'staticGenerate']
  gruntfile:
    files: ['Gruntfile.js']
  public:
    files: ['<%= yeoman.app %>/public/*']
    tasks: ['copy:public']
  livereload:
    files: [
      '<%= yeoman.app %>/{,*/}*.html'
      '!<%= yeoman.app %>/index.html'
      '.tmp/styles/{,*/}*.css'
      '.tmp/scripts/{,*/}*.js'
      '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
    ]

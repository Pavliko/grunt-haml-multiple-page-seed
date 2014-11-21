module.exports =
  bower:
    files: ['<%= yeoman.app %>/bower.json']
    tasks: ['wiredep']
    options:
      livereload: true
  coffee:
    files: ['<%= yeoman.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}']
    tasks: ['newer:coffee:dist']
    options:
      livereload: true
  styles:
    files: ['<%= yeoman.app %>/styles/{,*/}*.scss']
    tasks: ['libsass', 'newer:copy:styles', 'autoprefixer']
    options:
      livereload: true
  haml:
    files: ['<%= yeoman.app %>/**/*.haml']
    tasks: ['haml', 'staticGenerate']
    options:
      livereload: true
  gruntfile:
    files: ['Gruntfile.js']
  livereload:
    options:
      livereload: '<%= connect.options.livereload %>'
    files: [
      '<%= yeoman.app %>/{,*/}*.html'
      '.tmp/styles/{,*/}*.css'
      '.tmp/scripts/{,*/}*.js'
      '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
    ]

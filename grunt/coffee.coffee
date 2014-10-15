module.exports =
  options:
    sourceMap: true
    sourceRoot: ''
  dist:
    files: [
        expand: true
        cwd: '<%= yeoman.app %>/scripts'
        src: '{,*/}*.coffee'
        dest: '.tmp/scripts'
        ext: '.js'
    ]

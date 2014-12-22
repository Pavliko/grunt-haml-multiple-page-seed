module.exports =
  dist:
    files: [
        expand: true
        cwd: '<%= yeoman.app %>/scripts'
        src: '{,*/}*.cjsx'
        dest: '.tmp/scripts'
        ext: '.js'
    ]

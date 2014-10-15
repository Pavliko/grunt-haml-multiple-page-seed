module.exports =
  options:
    sourceMap: true
  dist:
    files: [
        expand: true
        cwd: '<%= yeoman.app %>/styles'
        src: '**/*.scss'
        dest: '.tmp/styles'
        ext: '.css'
    ]

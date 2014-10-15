module.exports =
  server: [
    'coffee:dist'
    'copy:styles'
  ]
  dist: [
    'coffee'
    'libsass'
    'copy:styles'
    'imagemin'
    'svgmin'
  ]

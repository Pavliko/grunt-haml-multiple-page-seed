module.exports =
  server: [
    'beforeConcurrentServer'
    'coffee:dist'
    'copy:styles'
  ]
  dist: [
    'beforeConcurrent'
    'coffee'
    'libsass'
    'copy:styles'
    'imagemin'
    'svgmin'
  ]

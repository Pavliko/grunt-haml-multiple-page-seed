module.exports =
  server: [
    'beforeConcurrentServer'
    'coffee:dist'
    'copy:styles'
  ]
  dist: [
    'beforeConcurrent'
    'coffee'
    'sass'
    'copy:styles'
    'imagemin'
    'svgmin'
  ]

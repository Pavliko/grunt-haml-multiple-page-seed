extend = exports.extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

module.exports = (grunt) ->
  path = require('path')
  mappingsPath = 'app/mappings.json'

  staticMappings =
    useminPrepare: 'grunt-usemin'
  if grunt.file.exists(mappingsPath)
    extend staticMappings, grunt.file.readJSON(mappingsPath)

  require('time-grunt') grunt
  require('load-grunt-config') grunt,
    configPath: path.join(process.cwd(), 'grunt')
    overridePath: path.join(process.cwd(), 'app', 'grunt')
    jitGrunt:
      staticMappings: staticMappings
      customTasksDir: 'custom'

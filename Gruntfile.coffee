module.exports = (grunt) ->
  path = require('path')
  require('time-grunt') grunt
  require('load-grunt-config') grunt,
    configPath: path.join(process.cwd(), 'grunt')
    overridePath: path.join(process.cwd(), 'app', 'grunt')
    jitGrunt:
      staticMappings:
        useminPrepare: 'grunt-usemin'
      customTasksDir: 'custom'

module.exports = (grunt) ->
  path = require('path')
  require('time-grunt') grunt
  require('load-grunt-config') grunt,
    overridePath: path.join(process.cwd(), 'app', 'grunt')
    configPath: path.join(process.cwd(), 'grunt')
    jitGrunt:
      staticMappings:
        useminPrepare: 'grunt-usemin'
      customTasksDir: 'custom'

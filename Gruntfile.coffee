module.exports = (grunt) ->
  require('time-grunt') grunt
  require('load-grunt-config') grunt,
    jitGrunt:
      staticMappings:
        useminPrepare: 'grunt-usemin'
      customTasksDir: 'custom'

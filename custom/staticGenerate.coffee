module.exports = (grunt) ->
  grunt.registerTask 'staticGenerate', 'Making static files',  ->
    appDir = @options()['appDir'] || 'app'
    dir = @options()['contentsDir'] || "#{appDir}/contents"
    dist = @options()['dist'] || appDir

    layout = grunt.file.read(@options()['layout'] || "#{appDir}/index.html")
    regexp = new RegExp(dir)
    
    grunt.file.recurse dir, (abspath, rootdir, subdir, filename) ->
      return unless /\.html$/.test(filename)
      content = grunt.file.read(abspath)
      newPath = abspath.replace(regexp, dist)
      console.log 'staticGenerate', newPath
      grunt.file.write newPath, layout.replace(/<!-- ##content## -->/, content)

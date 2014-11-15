module.exports = (grunt) ->
  grunt.registerTask 'staticGenerate', 'Making static files',  ->
    appDir = @options()['appDir'] || 'app'
    dir = @options()['contentsDir'] || "#{appDir}/contents"
    dist = @options()['dist'] || appDir

    [beforeContent, afterContent] = grunt.file
      .read(@options()['layout'] || "#{appDir}/index.html")
      .split('<!-- ##content## -->')

    header = grunt.file.read("#{appDir}/partials/header.html")
    footer = grunt.file.read("#{appDir}/partials/footer.html")

    renderContent = (content) ->
      "#{beforeContent} #{header} #{content} #{footer} #{afterContent}"

    regexp = new RegExp(dir)

    grunt.file.recurse dir, (abspath, rootdir, subdir, filename) ->
      return unless /\.html$/.test(filename)
      content = grunt.file.read(abspath)
      newPath = abspath.replace(regexp, dist)
      console.log 'staticGenerate', newPath
      grunt.file.write newPath, renderContent(content)

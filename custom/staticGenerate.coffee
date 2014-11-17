module.exports = (grunt) ->
  grunt.registerTask 'staticGenerate', 'Making static files', (target) ->
    isDist = target == 'dist'

    appDir = @options()['appDir'] || 'app'
    distDir = @options()['distDir'] || 'dist'
    dir = @options()['contentsDir'] || "#{appDir}/contents"
    tmpDir = @options()['tmpDir'] || '.tmp'

    [beforeContent, afterContent] = grunt.file
      .read(if isDist then "#{distDir}/index.html" else "#{appDir}/index.html")
      .split('<!-- ##content## -->')

    beforeContent = beforeContent.replace '<!-- ##header## -->',
      grunt.file.read("#{appDir}/partials/header.html")
    footer = afterContent.replace '<!-- ##footer## -->',
      grunt.file.read("#{appDir}/partials/footer.html")

    renderContent = (content) ->
      "#{beforeContent}#{content}#{afterContent}"

    regexp = new RegExp(dir)

    grunt.file.recurse dir, (abspath, rootdir, subdir, filename) ->
      return unless /\.html$/.test(filename)
      content = grunt.file.read(abspath)
      newPath = abspath.replace(regexp, if isDist then distDir else tmpDir)
      console.log 'staticGenerate', newPath
      grunt.file.write newPath, renderContent(content)

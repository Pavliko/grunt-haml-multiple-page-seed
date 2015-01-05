module.exports = (grunt) ->
  grunt.registerTask 'staticGenerate', 'Making static files', (target) ->
    isDist = target == 'dist'

    appDir = @options()['appDir'] || 'app'
    distDir = @options()['distDir'] || 'dist'
    dir = @options()['contentsDir'] || "#{appDir}/contents"
    tmpDir = @options()['tmpDir'] || '.tmp'

    layout = grunt.file
      .read(if isDist then "#{distDir}/index.html" else "#{appDir}/index.html")

    header = grunt.file.read("#{appDir}/partials/header.html") if grunt.file.exists("#{appDir}/partials/header.html")
    footer = grunt.file.read("#{appDir}/partials/footer.html") if grunt.file.exists("#{appDir}/partials/footer.html")

    renderContent = (blocks) ->
      result = layout
      for key, value of blocks
        result = result.replace("<!-- ####{key}### -->", value)
      result


    pathRegexp = new RegExp(dir)
    blockNameRegexp = /<!--\s*###([^#]+)###\s*-->/

    grunt.file.recurse dir, (abspath, rootdir, subdir, filename) ->
      return unless /\.html$/.test(filename)
      blocks =
        header: header
        footer: footer

      for block in grunt.file.read(abspath).split("<!-- ###end### -->")
        result = blockNameRegexp.exec(block)
        blocks[result[1]] = block.replace(result[0], '').trim() if result

      newPath = abspath.replace(pathRegexp, if isDist then distDir else tmpDir)
      grunt.file.write newPath, renderContent(blocks)

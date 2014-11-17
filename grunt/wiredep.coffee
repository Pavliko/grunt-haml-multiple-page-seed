module.exports =
  app:
    src: ['<%= yeoman.app %>/index.html']
    ignorePath: /\.\.\//
  sass:
    src: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}']
    # ignorePath: /(\.\.\/){1,2}bower_components\//
  js:
    src: ['<%= yeoman.app %>/index.html']
    exclude: [
      /jquery/
      /bower_components\/bootstrap-sass-official/
    ]
    ignorePath: /\.\.\//

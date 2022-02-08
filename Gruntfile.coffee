webpackConfig = require './webpack.config.js'

module.exports = (grunt)=>
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean :
      src : [ "build/"]
    copy:
      main:
        nonull:true
        expand: true
        cwd: 'src/server'
        src: '**/*'
        dest: 'build/server'
    webpack:
      options:
        stats: !process.env.NODE_ENV || process.env.NODE_ENV is "development"
      prod: webpackConfig
      dev: Object.assign({ watch: false }, webpackConfig)
    nodemon:
      dev:
        script: 'build/server/index.js'
    concurrent:
      target:
        tasks: ['nodemon', 'open', 'watch']
        options:
          logConcurrentOutput: true
    watch:
      server:
        files: ['src/server/**/*']
        tasks: ['copy']
      public:
        files: ['src/public/**/*']
        tasks: ['webpack']
      build:
        files: ['build/**/*']
        options:
          livereload: 12345
    open :
      dev :
        path: 'http://127.0.0.1:3000'

  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['clean', 'copy', 'webpack', 'concurrent:target']

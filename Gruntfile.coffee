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
        flatten: true
        src: 'src/server/*'
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
        tasks: ['webpack', 'nodemon', 'open', 'watch']
        options:
          logConcurrentOutput: true
    watch:
      server:
        files: ['src/**/*.*', 'build/**/*.*', 'Gruntfile.coffee']
        tasks: ['clean', 'copy', 'webpack']
        options:
          reload: true
          livereload: 12345
    open :
     dev :
       path: 'http://127.0.0.1:3000'
       app: 'Google Chrome'

  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['clean', 'copy', 'concurrent:target']

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      tmp: ['.tmp']

    phpunit:
      unit:
        dir: 'tests'
      options:
        bin: 'vendor/bin/phpunit'
        colors: true
        logJunit: 'tests/report.xml'
        followOutput: true
        stopOnError: true
        stopOnFailure: true

    sass:
      dist:
        files: [{
          expand: true
          cwd: 'styles'
          src: ['*.scss']
          dest: 'css'
          ext: '.css'
        }]

    coffee:
      dist:
        files: [{
          expand: true
          cwd: 'scripts'
          src: ['*.coffee']
          dest: 'js'
          ext: '.js'
        }]

    watch:
      styles:
        files: ['**/*.scss']
        tasks: ['sass']

      scripts:
        files: ['**/*.coffee']
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-phpunit'

  grunt.registerTask 'test', "Run tests", ['phpunit']

  # TODO
  grunt.registerTask 'build', "Build the static site", [
  ]

  grunt.registerTask 'serve', [
    'clean',
    'sass',
    'coffee',
    'watch'
  ]

  grunt.registerTask 'default', ['test']

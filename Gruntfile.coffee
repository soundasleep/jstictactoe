module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      dist: ['dist']

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

    copy:
      dist:
        files: [{
          expand: true,
          cwd: '.'
          src: ['index.html', 'css/**/*', 'js/**/*']
          dest: 'dist'
        }]

      nodeModulesJs:
        files: [{
          expand: true
          cwd: 'node_modules/'
          src: ['**/*.js']
          dest: 'dist/node_modules/'
        }]

    useminPrepare:
      html: 'dist/index.html'

    usemin:
      html: ['dist/index.html']

    watch:
      styles:
        files: ['**/*.scss']
        tasks: ['sass']

      scripts:
        files: ['**/*.coffee']
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-phpunit'
  grunt.loadNpmTasks 'grunt-usemin'

  grunt.registerTask 'test', "Run tests", ['phpunit']

  grunt.registerTask 'build', "Build the static site", [
    'clean',
    'sass',
    'coffee',
    'copy:dist',
    'copy:nodeModulesJs',
    'useminPrepare',
    'concat',
    'uglify',
    'usemin',
  ]

  grunt.registerTask 'serve', [
    'clean',
    'sass',
    'coffee',
    'watch'
  ]

  grunt.registerTask 'default', ['test']

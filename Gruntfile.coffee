module.exports = (grunt) ->
  pkg = grunt.file.readJSON("package.json")
  package_name = "execute_method"

  grunt.initConfig
    pkg:pkg
    package_name: package_name

    banner: grunt.file.read("./src/copy.js").replace(/@VERSION/, pkg.version).replace(/@DATE/, grunt.template.today("yyyy-mm-dd")) + "\n"

    clean: ["dist", "dev", "tmp"]

    coffeelint:
      app: ['src/**/*.coffee']
      tests:
        files:
          src: ['src/test/*.coffee']
      options:
        force:true
        max_line_length:
          value: 100
          limitComments: false

    concat:
      options:
        banner: "<%= banner %>"
        separator: ";\n"
      dist:
        dest: 'dist/<%= package_name %>-<%= pkg.version %>.js'

    uglify:
      options:
        banner: "<%= banner %>"
        report: "min"
      dist:
        dest: 'dist/<%= package_name %>-<%= pkg.version %>.min.js'
        src: ['dist/<%= package_name %>-<%= pkg.version %>.js']

    watch:
      all:
        files: [
          "src/*.coffee"
          "src/test/*.coffee"
        ]
        tasks: ["coffeelint", "coffee:compile_dev", "coffee:compile_test"]
        # tasks: ["coffeelint", "coffee:compile_dev", "coffee:compile_test", "qunit"]

    qunit:
      options:
        phantomPath: "/usr/local/bin/phantomjs"
      files: ['test/**/*.html']

    coffee:
      compile_dev:
        options:
          bare: true
          sourceMap: true
        files:
          'dev/<%= package_name %>.js' : ['src/*.coffee']

      compile_dist:
        options:
          bare: true
          sourceMap: false
        files:
          'tmp/<%= package_name %>.js' : ['src/*.coffee']

      compile_test:
        options:
          bare: true
          sourceMap: true
        files:
          'test/<%= package_name %>.js' : ['src/test/**/*.coffee']

    # gzip assets 1-to-1 for production
    compress:
      main:
        options:
          mode: 'gzip'
        expand: true
        # cwd: 'dist/'
        src: ['dist/*.js']
        # dest: 'dist/'

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-compress'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-croc-qunit'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask('default', ['clean', 'coffeelint', 'coffee', 'qunit', 'concat', 'uglify', 'compress'])
  grunt.registerTask('build', ['clean', 'coffeelint', 'coffee', 'concat', 'uglify', 'compress'])
  return

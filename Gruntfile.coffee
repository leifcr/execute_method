module.exports = (grunt) ->
  pkg = grunt.file.readJSON("package.json")
  package_name = "execute_method"

  grunt.initConfig
    pkg:pkg
    package_name: package_name

    banner: grunt.file.read("./src/copy.js").replace(/@VERSION/, pkg.version).replace(/@DATE/, grunt.template.today("yyyy-mm-dd")) + "\n"

    clean: ["dist", "build", "tmp"]

    coffeelint:
      app: ['src/**/*.coffee']
      options:
        force:true
        max_line_length:
          value: 100
          limitComments: false

    concat:
      options:
        banner: "<%= banner %>"
        separator: ";\n"
        stripBanners: true
      dist:
        src: ["build/execute_method.js"]
        dest: 'dist/<%= package_name %>.js'

    uglify:
      options:
        banner: "<%= banner %>"
        report: "min"
      dist:
        dest: 'dist/<%= package_name %>.min.js'
        src: ['dist/<%= package_name %>.js']

    watch:
      all:
        files: [
          "src/*.coffee"
          "src/test/*.coffee"
        ]
        tasks: ["coffeelint", "coffee:compile_build", "coffee:compile_test"]
        # tasks: ["coffeelint", "coffee:compile_build", "coffee:compile_test", "qunit"]

    qunit:
      options:
        # phantomPath: "/usr/local/bin/phantomjs"
        coverage: {
          src: "build/execute_method.js",
          instrumentedFiles: "temp/",
          htmlReport: "build/report/coverage",
          lcovReport: "build/report/lcov",
          linesThresholdPct: 95
        }
      all: ['test/**/*.html']

    coffee:
      compile_build:
        options:
          bare: true
          sourceMap: true
        files:
          'build/<%= package_name %>.js' : ['src/*.coffee']

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
  # grunt.loadNpmTasks 'grunt-croc-qunit'
  grunt.loadNpmTasks 'grunt-qunit-istanbul'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask('default', ['clean', 'coffeelint', 'coffee', 'qunit', 'concat', 'uglify'])
  grunt.registerTask('build', ['clean', 'coffeelint', 'coffee', 'concat', 'uglify'])
  return

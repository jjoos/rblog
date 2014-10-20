module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      compile: {
        files: ['src/*.coffee', 'src/client/*.coffee', 'src/util/*.coffee'],
        tasks: ['compile']
      },

      lint: {
        files: ['src/**/*.coffee'],
        tasks: ['coffeelint']
      }
    },

    cjsx: {
      glob_to_multiple: {
        expand: true,
        cwd: 'src',
        src: ['*.coffee', 'client/**/*.coffee', 'util/**/*.coffee'],
        dest: 'tmp/',
        ext: '.js'
      }
    },

    browserify: {
      all: {
        src: 'tmp/client/client.js',
        dest: 'assets/bundle.js'
      }
    },

    coffeelint: {
      app: ['src/**/*.coffee']
    }
  });

  grunt.loadNpmTasks('grunt-coffee-react');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-traceur');
  grunt.loadNpmTasks('grunt-coffeelint');

  grunt.registerTask('default', ['watch']);
  grunt.registerTask('compile', ['cjsx', 'browserify']);
};

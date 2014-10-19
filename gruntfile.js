module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      compile: {
        files: ['src/**/*.coffee'],
        tasks: ['compile', 'coffeelint']
      }
    },

    browserify: {
      all: {
        src: 'tmp/client.js',
        dest: 'assets/bundle.js'
      }
    },

    cjsx: {
      compile: {
        files: {
          'tmp/client.js': 'src/client.coffee',
          'tmp/views.js': 'src/views.coffee'
        }
      }
    },

    coffeelint: {
      app: ['src/**/*.coffee']
    }
  });

  grunt.loadNpmTasks('grunt-coffee-react');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.registerTask('default', ['watch']);
  grunt.registerTask('compile', ['cjsx', 'browserify']);
};

module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      lint: {
        files: ['src/**/*.coffee'],
        tasks: ['coffeelint']
      }
    },

    browserify: {
      all: {
        src: 'src/client/client.coffee',
        dest: 'assets/bundle.js',
        options: {
          browserifyOptions: {
            debug: true
          },
          transform: ['coffee-reactify', 'es6ify']
        }
      },

      watch: {
        src: 'src/client/client.coffee',
        dest: 'assets/bundle.js',
        options: {
          browserifyOptions: {
            debug: true
          },
          transform: ['coffee-reactify', 'es6ify'],
          watch: true,
          keepAlive: true
        }
      }
    },

    concurrent: {
      watch: ['watch', 'browserify:watch'],
      options: {
        logConcurrentOutput: true
      }
    },

    coffeelint: {
      app: ['src/**/*.coffee']
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-concurrent');

  grunt.registerTask('default', ['concurrent:watch']);
  grunt.registerTask('compile', ['browserify']);
};

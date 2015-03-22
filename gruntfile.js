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
        src: 'src/client/application.coffee',
        dest: 'assets/client.js',
        options: {
          browserifyOptions: {
            debug: true,
            extensions: ['.coffee', '.cjsx']
          },
          transform: ['coffee-reactify', [{filePattern: /\.(js|coffee|cjsx)$/}, 'babelify']]
        }
      },

      watch: {
        src: 'src/client/application.coffee',
        dest: 'assets/client.js',
        options: {
          browserifyOptions: {
            debug: true,
            extensions: ['.coffee', '.cjsx']
          },
          transform: ['coffee-reactify', [{filePattern: /\.(js|coffee|cjsx)$/}, 'babelify']],
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
      app: ['src/**/*.coffee'],
      options: {
        configFile: 'coffeelint.json'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-concurrent');

  grunt.registerTask('default', ['concurrent:watch']);
  grunt.registerTask('compile', ['browserify']);
};

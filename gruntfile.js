module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      compile: {
        files: ['src/**/*.coffee'],
        tasks: ['compile', 'coffeelint']
      }
    },

    cjsx: {
      glob_to_multiple: {
        expand: true,
        flatten: false,
        cwd: 'src',
        src: ['**/*.coffee'],
        dest: 'tmp/es6',
        ext: '.js'
      }
    },

    traceur: {
      options: {
        experimental: true,
        blockBinding: true
      },
      custom: {
        files: [{
          expand: true,
          cwd: 'tmp/es6',
          src: '**/*.js',
          dest: 'tmp/es5'
        }]
      },
    },

    browserify: {
      all: {
        src: 'tmp/es5/client.js',
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
  grunt.registerTask('compile', ['cjsx', 'traceur', 'browserify']);
};

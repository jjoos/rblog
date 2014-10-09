module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      compile: {
        files: ['src/**/*.coffee'],
        tasks: ['compile']
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
  });

  grunt.loadNpmTasks('grunt-coffee-react');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');

  grunt.registerTask('default', ['watch']);
  grunt.registerTask('compile', ['cjsx', 'browserify']);
};

module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      tasks: ["compile"]
    },

    browserify: {
      all: {
        src: 'tmp/index.js',
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

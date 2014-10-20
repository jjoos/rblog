module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      compile: {
        files: ['src/*.coffee', 'src/client/*.coffee'],
        tasks: ['compile']
      },

      lint: {
        files: ['src/**/*.coffee'],
        tasks: ['coffeelint']
      }
    },

    browserify: {
      all: {
        src: 'tmp/es5/client/client.js',
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
  grunt.loadNpmTasks('grunt-coffeelint');

  grunt.registerTask('default', ['watch']);
  grunt.registerTask('compile', ['cjsx', 'traceur', 'browserify']);
};

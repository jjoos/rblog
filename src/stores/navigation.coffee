{Store} = require './../../vendor/eightyeight/src/eightyeight.coffee'

constants = require './../constants.coffee'

module.exports = class extends Store
  storeName: 'navigation'

  constructor: (dispatcher) ->
    super

    for _key, value of constants.navigation
      @_addListener value, (options) =>
        @_handleNavigation(options)

  data: ->
    @_options

  _handleNavigation: (options) =>
    @_options = options.data

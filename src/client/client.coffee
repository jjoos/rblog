require 'traceur/bin/traceur-runtime'

$ = require 'jquery'

View = require '../view'
Router = require './router'
Data = require '../data'

$(document).ready ->
  router = new Router(Data, View)

  $(document).on "click", "a:not([data-bypass])", (event) ->
    href = $(this).attr 'href'
    root = "#{location.protocol}//#{location.host}/"
    if (href.prop && href.prop.slice(0, root.length) == root) ||
       (href[0] == '/' && href[1] != '/')

      router.navigate href, true
      event.preventDefault()

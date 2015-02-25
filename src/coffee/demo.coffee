requirejs.config
  shim:
    'bootstrap': {'deps': ['jquery']}

  paths:
    'jquery': '../../bower_components/jquery/dist/jquery'
    'bootstrap': '../../bower_components/bootstrap-sass/assets/javascripts/bootstrap'

requirejs ['jquery', 'bootstrap', 'catbus'], ($) -> $ ->

  $body = $('body')
  $buttons = $('[js-demo-buttons]')

  config = 'top'
  config = 'left' if $body.hasClass 'catbus-left'
  config = 'right' if $body.hasClass 'catbus-right'

  changePlaces = (e) ->
    oldPlace = config

    # force change if you send in a string
    if typeof e is 'string'
      newPlace = e
      $buttons.find("[for=\"#{newPlace}\"]").trigger 'click'

    else
      $input = $(e.target)
      newPlace = $input.val()

    config = newPlace

    $body
      .removeClass "catbus-#{oldPlace}"
      .addClass "catbus-#{newPlace}"

  init = ->
    changePlaces config
    $buttons.on 'change', changePlaces

  do init

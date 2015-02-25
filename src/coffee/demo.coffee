requirejs.config
  shim:
    'bootstrap': {'deps': ['jquery']}

  paths:
    'jquery': '../../bower_components/jquery/dist/jquery'
    'bootstrap': '../../bower_components/bootstrap-sass/assets/javascripts/bootstrap'

requirejs ['jquery', 'bootstrap', 'catbus'], ($) -> $ ->

  $body = $('body')
  $catbus = $('[js-catbus]')
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

  changeHeader = (e) ->
    type = $(e.target).val()
    opposite = if type is 'open' then 'standard' else 'open'

    incoming = "[js-navbar-#{type}]"
    outgoing = "[js-navbar-#{opposite}]"

    $(outgoing).addClass 'hide'
    $(incoming).removeClass 'hide'

  # The Sneakiness!
  #
  # This disables all the catbus animations while you're hovering over the
  # buttons that pick which side the catbus is on.
  disableAnim = (bool) ->
    $catbus.toggleClass 'disable-anim', bool

  init = ->
    changePlaces config
    $buttons
      .on 'change', changePlaces
      .on 'mouseenter', -> disableAnim(true)
      .on 'mouseleave', -> disableAnim(false)

    $('#js-navbar-config').on 'change', changeHeader

  do init

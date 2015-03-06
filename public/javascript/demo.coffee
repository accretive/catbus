requirejs.config
  shim:
    'bootstrap': {'deps': ['jquery']}

  paths:
    'jquery': '../components/jquery/dist/jquery'
    'bootstrap': '../components/bootstrap-sass/assets/javascripts/bootstrap'

requirejs ['jquery', 'bootstrap', 'catbus'], ($) -> $ ->

  $body = $('body')
  $catbus = $('[js-catbus]')
  $buttons = $('[js-demo-buttons]')

  config = 'top'
  config = 'left' if $body.hasClass 'catbus--left'
  config = 'right' if $body.hasClass 'catbus--right'

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
      .removeClass "catbus--#{oldPlace}"
      .addClass "catbus--#{newPlace}"

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
  toggleAnim = (bool) ->

    # Disabling makes more sense from a CSS standpoint, so this is a little
    # weird looking at first.
    $catbus.toggleClass 'disable-anim', !bool


  init = ->
    changePlaces config

    $buttons
      .on 'change', changePlaces
      .on 'mouseenter', -> toggleAnim(false)
      .on 'mouseleave', -> toggleAnim(true)

    $('#js-navbar-config').on 'change', changeHeader

    # Delay enabling the animations until after we've opened the catbus.
    setTimeout (-> toggleAnim true), 300

  do init

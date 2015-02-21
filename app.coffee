$ ->

  $body = $('body')
  $catbusTail = $('[js-catbus-tail]')
  $clickables = $('[js-catbus-button], [js-catbus-tail]')

  catbusOpen = $body.hasClass 'catbus-open'
  transitionStrings = 'webkitTransitionEnd otransitionend msTransitionEnd transitionend'

  toggleCatbus = ->
    catbusOpen = !catbusOpen
    $body.toggleClass 'catbus-open', catbusOpen

  toggleTail = (e) ->
    $tail = $(e.currentTarget)
    $tail.toggleClass 'hide', !catbusOpen

  $clickables.on 'click', toggleCatbus
  $catbusTail.on transitionStrings, toggleTail

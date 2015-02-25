# #
# # @author Daryl Roberts
# # @license MIT
# #

# # This is a swanky AMD wrapper that I first saw used in jquery.cookie
# # here: https://github.com/carhartl/jquery-cookie
# ((factory) ->

#   # Require.js
#   if typeof define is 'function' and define.amd
#     define ['jquery'], factory

#   # CommonJs (Node)
#   else if typeof exports is 'object'
#     factory require 'jquery'

#   # Browser
#   else factory jQuery

# ) ($) -> $ ->


define ['jquery'], ($) ->

  # Cached jquery references
  $body = $('body')
  $catbusTail = $('[js-catbus-tail]')
  $clickables = $('[js-catbus-button], [js-catbus-tail]')

  # Local storage keys
  LS_CATBUS_STATUS = 'catbus-status'
  LS_STORED_PINNED = 'pinned'
  LS_STORED_CLOSED = 'closed'

  catbusOpen = $body.hasClass 'catbus-open'
  transitionEnd = 'webkitTransitionEnd otransitionend msTransitionEnd transitionend'

  catbusPinned = ->
    status = localStorage.getItem LS_CATBUS_STATUS

    pinned = false
    pinned = true if status is LS_STORED_PINNED

    do toggleCatbus if pinned isnt catbusOpen

  toggleLocalStorage = (open) ->
    store = if open then LS_STORED_PINNED else LS_STORED_CLOSED
    localStorage.setItem LS_CATBUS_STATUS, store

  toggleCatbus = ->
    catbusOpen = !catbusOpen
    $body.toggleClass 'catbus-open', catbusOpen
    toggleLocalStorage catbusOpen

  toggleTail = ->
    $catbusTail.toggleClass 'hide', !catbusOpen

  init = ->
    $clickables.on 'click', toggleCatbus
    $catbusTail.on transitionEnd, toggleTail
    do catbusPinned

  do init

#
# @author Daryl Roberts
# @license MIT
#

# This silly line is the require line and the jQuery function start
define ['jquery'], ($) ->
  $(document).ready ->

    # Cached jquery references
    $body = $('body')

    # @todo
    # $dismissables = $('[js-catbus-dismiss]')

    $catbusTail = $('[js-catbus-tail]')
    $clickables = $catbusTail.add('[js-catbus-button]')

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

      return pinned

    setLocalStorate = (open) ->
      store = if open then LS_STORED_PINNED else LS_STORED_CLOSED
      localStorage.setItem LS_CATBUS_STATUS, store


    openCatbus = -> toggleCatbus true
    closeCatbus = -> toggleCatbus false

    toggleCatbus = (force) ->
      if typeof(force) isnt "boolean"
        force = null

      catbusOpen = force or !catbusOpen
      $body.toggleClass 'catbus-open', catbusOpen
      setLocalStorate catbusOpen

    toggleTail = ->
      $catbusTail.toggleClass 'hide', !catbusOpen

    closeForDismissableClick = ->
      if $catbusTail.is(':visible') and catbusOpen
        closeCatbus()

    init = ->
      $clickables.on 'click', toggleCatbus
      $catbusTail.on transitionEnd, toggleTail

      if catbusPinned() then openCatbus()

    init()

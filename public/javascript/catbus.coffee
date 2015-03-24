#
# @author Daryl Roberts
# @license MIT
#

# This silly line is the require line and the jQuery function start
define 'doc', ->
  return document

define ['jquery', 'doc'], ($, doc) ->

  # jQuery Object References
  $body            =
  $catbus          =
  $catbusTail      =
  $clickables      = {}

  # Local storage constants
  LS_CATBUS_STATUS = 'catbus-status'
  LS_STORED_PINNED = 'pinned'
  LS_STORED_CLOSED = 'closed'

  # Other stuff.
  catbusOpen       = false

  ###*
   * Tells us if local storage says the catbus is pinned open or not.
  ###
  catbusPinned = ->
    status = localStorage.getItem LS_CATBUS_STATUS

    pinned = false
    pinned = true if status is LS_STORED_PINNED

    return pinned

  ###*
   * Set the local storage parameter to open or closed.
   *
   * I'm doing this with local storage because if we use the disable animation
   * trick from the demo, I Think we can cut out the need for anything to be
   * done server side. That being said, I'm still using string values in case
   * this needs to be switched back to cookies :)
   *
   * @param {boolean} open which way to set the value.
  ###
  setLocalStorage = (open) ->
    store = if open then LS_STORED_PINNED else LS_STORED_CLOSED
    localStorage.setItem LS_CATBUS_STATUS, store

  ###*
   * Toggle the catbus open or closed
   *
   * @param  {boolean} force specify which way the catbus is supposed to move.
  ###
  toggleCatbus = (force) ->

    newStatus = false

    if force is false or force is true
      newStatus = force
    else
      newStatus = !catbusOpen

    $body.toggleClass 'catbus-open', newStatus
    setLocalStorage newStatus
    catbusOpen = newStatus

    statusString = "closed"
    statusString = "open" if newStatus

    $catbus.trigger "#{statusString}.atg.catbus"

  # Yep
  openCatbus = -> toggleCatbus true
  closeCatbus = -> toggleCatbus false

  ###*
   * You can't use CSS transitions through display states :(
  ###
  toggleTail = ->
    $catbusTail.toggleClass 'hide', !catbusOpen

  ###*
   * Catbus init!
  ###
  init = ->
    $(doc).ready ->
      transitionEnd = 'webkitTransitionEnd otransitionend msTransitionEnd transitionend'

      $body       = $('body')
      $catbus     = $('[js-catbus]')
      $catbusTail = $('[js-catbus-tail]')
      $clickables = $catbusTail.add('[js-catbus-button]')

      catbusOpen = $body.hasClass 'catbus-open'

      $clickables.on 'click', toggleCatbus
      $catbusTail.on transitionEnd, toggleTail

      if catbusPinned() then openCatbus() else closeCatbus()

  # Unless we have reason not to, initialize the catbus as soon as we
  # get required.
  init() unless doc.haltCatbus

  return {
    init, openCatbus, closeCatbus
    catbusStatus: -> catbusOpen
  }

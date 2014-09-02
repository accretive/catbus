$ ->

  catbusConfig = 'left'

  catbusOpen = false
  catbusOpenSpeed = 250

  catbusPinned = false
  catbusNavHeight = 108

  $('[js-catbus-tail]').on 'click', ->
    catbusOpen = !catbusOpen
    $('body').toggleClass 'catbus--open', catbusOpen

  $('[js-catbus-button]').on 'click', ->
    catbusOpen = !catbusOpen
    $('body').toggleClass 'catbus--open', catbusOpen

    # if catbusConfig is 'left'
    #   if catbusOpen then paddingLeft = catbusNavWidth
    #   else paddingLeft = 0

    #   $('[js-catbus-section]').velocity {paddingLeft}, catbusOpenSpeed

    # else if catbusConfig is 'right'
    #   if catbusOpen then paddingRight = catbusNavWidth
    #   else paddingRight = 0

    #   $('[js-catbus-section]').velocity {paddingRight}, catbusOpenSpeed

    # else if catbusConfig is 'top'
    #   if catbusOpen then top = catbusNavHeight
    #   else top = 0

    #   $('[js-catbus-section]').velocity {top}, catbusOpenSpeed



  $('#js-catbus-config').on 'change', (e) =>
    $ ".catbus--#{catbusConfig}"
      .toggleClass "catbus--#{catbusConfig}"
      .toggleClass "catbus--#{e.target.value}"

    catbusConfig = e.target.value

  $('.catbus__header .btn').on 'click', ->
    $(this).parent().remove()

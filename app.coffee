$ ->
  catbus_config = 'left'

  $('[js-catbus-button]').on 'click', ->
    $('body').toggleClass 'catbus-open'

  $('#js-catbus-config').on 'change', (e) ->
    $ ".catbus--#{catbus_config}"
      .toggleClass "catbus--#{catbus_config}"
      .toggleClass "catbus--#{e.target.value}"

    catbus_config = e.target.value

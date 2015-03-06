requirejs.config({
  shim: {
    'bootstrap': {
      'deps': ['jquery']
    }
  },
  paths: {
    'jquery': '../components/jquery/dist/jquery',
    'bootstrap': '../components/bootstrap-sass/assets/javascripts/bootstrap'
  }
});

requirejs(['jquery', 'bootstrap', 'catbus'], function($) {
  return $(function() {
    var $body, $buttons, $catbus, changeHeader, changePlaces, config, init, toggleAnim;
    $body = $('body');
    $catbus = $('[js-catbus]');
    $buttons = $('[js-demo-buttons]');
    config = 'top';
    if ($body.hasClass('catbus--left')) {
      config = 'left';
    }
    if ($body.hasClass('catbus--right')) {
      config = 'right';
    }
    changePlaces = function(e) {
      var $input, newPlace, oldPlace;
      oldPlace = config;
      if (typeof e === 'string') {
        newPlace = e;
        $buttons.find("[for=\"" + newPlace + "\"]").trigger('click');
      } else {
        $input = $(e.target);
        newPlace = $input.val();
      }
      config = newPlace;
      return $body.removeClass("catbus--" + oldPlace).addClass("catbus--" + newPlace);
    };
    changeHeader = function(e) {
      var incoming, opposite, outgoing, type;
      type = $(e.target).val();
      opposite = type === 'open' ? 'standard' : 'open';
      incoming = "[js-navbar-" + type + "]";
      outgoing = "[js-navbar-" + opposite + "]";
      $(outgoing).addClass('hide');
      return $(incoming).removeClass('hide');
    };
    toggleAnim = function(bool) {
      return $catbus.toggleClass('disable-anim', !bool);
    };
    init = function() {
      changePlaces(config);
      $buttons.on('change', changePlaces).on('mouseenter', function() {
        return toggleAnim(false);
      }).on('mouseleave', function() {
        return toggleAnim(true);
      });
      $('#js-navbar-config').on('change', changeHeader);
      return setTimeout((function() {
        return toggleAnim(true);
      }), 300);
    };
    return init();
  });
});

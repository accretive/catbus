define(['jquery'], function($) {
  return $(document).ready(function() {
    var $body, $catbus, $catbusTail, $clickables, LS_CATBUS_STATUS, LS_STORED_CLOSED, LS_STORED_PINNED, catbusOpen, catbusPinned, closeCatbus, init, openCatbus, setLocalStorage, toggleCatbus, toggleTail;
    $body = $('body');
    $catbus = $('[js-catbus]');
    $catbusTail = $('[js-catbus-tail]');
    $clickables = $catbusTail.add('[js-catbus-button]');
    LS_CATBUS_STATUS = 'catbus-status';
    LS_STORED_PINNED = 'pinned';
    LS_STORED_CLOSED = 'closed';
    catbusOpen = $body.hasClass('catbus-open');

    /**
     * Tells us if local storage says the catbus is pinned open or not.
     */
    catbusPinned = function() {
      var pinned, status;
      status = localStorage.getItem(LS_CATBUS_STATUS);
      pinned = false;
      if (status === LS_STORED_PINNED) {
        pinned = true;
      }
      return pinned;
    };

    /**
     * Set the local storage parameter to open or closed.
     *
     * I'm doing this with local storage because if we use the disable animation
     * trick from the demo, I Think we can cut out the need for anything to be
     * done server side. That being said, I'm still using string values in case
     * this needs to be switched back to cookies :)
     *
     * @param {boolean} open which way to set the value.
     */
    setLocalStorage = function(open) {
      var store;
      store = open ? LS_STORED_PINNED : LS_STORED_CLOSED;
      return localStorage.setItem(LS_CATBUS_STATUS, store);
    };

    /**
     * Toggle the catbus open or closed
     *
     * @param  {boolean} force specify which way the catbus is supposed to move.
     */
    toggleCatbus = function(force) {
      var newStatus, statusString;
      newStatus = false;
      if (typeof force !== "boolean") {
        force = null;
        newStatus = !catbusOpen;
      }
      if (force === false || force) {
        newStatus = force;
      }
      $body.toggleClass('catbus-open', newStatus);
      setLocalStorage(newStatus);
      catbusOpen = newStatus;
      statusString = "closed";
      if (newStatus) {
        statusString = "open";
      }
      return $catbus.trigger(statusString + ".atg.catbus");
    };
    openCatbus = function() {
      return toggleCatbus(true);
    };
    closeCatbus = function() {
      return toggleCatbus(false);
    };

    /**
     * You can't use CSS transitions through display states :(
     * @return {jQuery Object} $catbusTail
     */
    toggleTail = function() {
      return $catbusTail.toggleClass('hide', !catbusOpen);
    };

    /**
     * Catbus init!
     */
    init = function() {
      var transitionEnd;
      transitionEnd = 'webkitTransitionEnd otransitionend msTransitionEnd transitionend';
      $clickables.on('click', toggleCatbus);
      $catbusTail.on(transitionEnd, toggleTail);
      if (catbusPinned()) {
        openCatbus();
      } else {
        closeCatbus();
      }
    };
    init();
    return {
      openCatbus: openCatbus,
      closeCatbus: closeCatbus,
      catbusStatus: function() {
        return catbusOpen;
      }
    };
  });
});

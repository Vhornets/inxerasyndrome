require.config({
  baseUrl: '../js',
  paths: {
    text: 'vendor/text',
    jquery: 'vendor/jquery.min',
    underscore: 'vendor/underscore.min',
    backbone: 'vendor/backbone.min',
    bootstrap: 'vendor/bootstrap.min',
    templates: '../templates',
    collections: './collections',
    models: './models',
    views: './views'
  }
});

define(['jquery', 'utils/cookies', './router'], function($, cookies, Router) {
  var router;
  router = new Router();
  $(document).on('hide.bs.modal', '#myModal', function(e) {
    if (window.history.length > 2) {
      return window.history.back();
    } else {
      window.history.pushState({
        main: 'main'
      }, "Main Page", "/");
      return window.history.go(0);
    }
  });
  return $('.content').on('view:ready', function(e) {
    $('#loader').hide('slow');
    $(cookies.get('cur-view-hide')).hide();
    return $(cookies.get('cur-view-show')).show();
  }).on('page:active', function(e, num) {
    return $('.page-num-' + (num + 1)).addClass('active');
  });
});

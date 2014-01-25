var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'views/downloads'], function(Backbone, DownloadsView) {
  var Router, _ref;
  return Router = (function(_super) {
    __extends(Router, _super);

    function Router() {
      _ref = Router.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Router.prototype.routes = {
      '': 'showDownloads',
      'downloads/*name': 'showRelease',
      'page/:page': 'renderPage',
      'play/*playlist': 'showPlayer',
      'filter/*filter': 'filterProjects',
      '*path': 'default'
    };

    Router.prototype.initialize = function() {
      this.view = new DownloadsView();
      return Backbone.history.start();
    };

    Router.prototype.showDownloads = function() {
      return this.view.render();
    };

    Router.prototype.showRelease = function(name) {
      if (!name) {
        return this.view.render();
      }
      return this.view.render(name);
    };

    Router.prototype.renderPage = function(page) {
      return this.view.render(false, page - 1);
    };

    Router.prototype.showPlayer = function(playlist) {
      return this.view.player(playlist);
    };

    Router.prototype.filterProjects = function(filter) {
      return this.view.render(false, 0, filter);
    };

    Router.prototype["default"] = function(path) {
      return this.view.render();
    };

    return Router;

  })(Backbone.Router);
});

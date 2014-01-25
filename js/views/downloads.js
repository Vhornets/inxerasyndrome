var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'underscore', 'backbone', 'utils/cookies', 'collections/releases', 'text!templates/downloads.tpl', 'text!templates/release.tpl', 'text!templates/player.tpl', 'bootstrap'], function($, _, Backbone, cookies, Releases, DownloadsTpl, ReleaseTpl, PlayerTpl) {
  var DownloadsView, _ref;
  return DownloadsView = (function(_super) {
    __extends(DownloadsView, _super);

    function DownloadsView() {
      _ref = DownloadsView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    DownloadsView.prototype.el = '.content';

    DownloadsView.prototype.events = {
      'click .controls>a': 'toggleView',
      'click .per-page>li>a': 'changePerPage'
    };

    DownloadsView.prototype.initialize = function() {
      this.perPage = 2;
      this.collection = new Releases();
      return this.template = '';
    };

    DownloadsView.prototype.render = function(name, page, filter) {
      var _this = this;
      if (name == null) {
        name = false;
      }
      if (page == null) {
        page = 0;
      }
      if (filter == null) {
        filter = false;
      }
      this.template = _.template(DownloadsTpl);
      return this.collection.fetch({
        success: function(col, data) {
          var release, releases;
          releases = filter && filter !== 'All' ? _.where(data.releases, {
            project: filter
          }) : data.releases;
          _this.$el.html(_this.template({
            releases: _this.paginate(releases, page, _this.perPage),
            pages: releases.length / _this.perPage < 1.25 ? 1 : Math.floor(releases.length / _this.perPage) + 1,
            projects: _.uniq(data.releases, true, function(el) {
              return el.project;
            }),
            currentFilter: filter ? filter : 'All',
            perPage: _this.perPage
          }));
          if (name) {
            release = _.where(data.releases, {
              name: name
            })[0];
            _this.template = _.template(ReleaseTpl);
            _this.modal({
              title: "" + release.project + " - " + release.title + " (" + release.year + ")",
              body: _this.template({
                release: release
              })
            });
          }
          return _this.$el.trigger('view:ready').trigger('page:active', page);
        }
      });
    };

    DownloadsView.prototype.player = function(playlist) {
      this.template = _.template(PlayerTpl);
      return this.modal({
        body: this.template({
          playlist: playlist
        })
      });
    };

    DownloadsView.prototype.toggleView = function(e) {
      var $currentControlBtn;
      e.preventDefault();
      $currentControlBtn = $(e.currentTarget);
      cookies.set('cur-view-show', $currentControlBtn.attr('data-show'), {
        expires: 3600000
      });
      cookies.set('cur-view-hide', $currentControlBtn.attr('data-hide'), {
        expires: 3600000
      });
      return this.$el.trigger('view:ready');
    };

    DownloadsView.prototype.changePerPage = function(e) {
      e.preventDefault();
      this.perPage = $(e.currentTarget).text();
      return this.render();
    };

    DownloadsView.prototype.filterProjects = function(e) {
      var filter;
      e.preventDefault();
      filter = $(e.currentTarget).text();
      if (filter === 'All') {
        return this.render(false, 0);
      } else {
        return this.render(false, 0, filter);
      }
    };

    DownloadsView.prototype.paginate = function(data, page, perPage) {
      data = _.rest(data, perPage * page);
      return data = _.first(data, perPage);
    };

    DownloadsView.prototype.modal = function(content) {
      $('.modal-body').html(content.body);
      $('.modal-title').html(content.title ? content.title : '');
      return $('#myModal').modal('show');
    };

    return DownloadsView;

  })(Backbone.View);
});

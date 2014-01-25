var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  var Release, _ref;
  return Release = (function(_super) {
    __extends(Release, _super);

    function Release() {
      _ref = Release.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Release.prototype.url = 'data/releases.json';

    return Release;

  })(Backbone.Model);
});

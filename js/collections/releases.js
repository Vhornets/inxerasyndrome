var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'models/release'], function(Backbone, Release) {
  var Releases, _ref;
  return Releases = (function(_super) {
    __extends(Releases, _super);

    function Releases() {
      _ref = Releases.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Releases.prototype.model = Release;

    Releases.prototype.url = 'data/releases.json';

    return Releases;

  })(Backbone.Collection);
});

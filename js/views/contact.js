// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require, module, exports) {
  var Backbone, ContactTpl, ContactView;
  Backbone = require('backbone');
  ContactTpl = require('text!templates/contact.tpl');
  return ContactView = (function(_super) {
    __extends(ContactView, _super);

    function ContactView() {
      return ContactView.__super__.constructor.apply(this, arguments);
    }

    ContactView.prototype.el = '.content';

    ContactView.prototype.render = function() {
      return this.$el.html(ContactTpl);
    };

    return ContactView;

  })(Backbone.View);
});
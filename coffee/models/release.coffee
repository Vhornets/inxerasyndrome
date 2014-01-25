define([
	'backbone'
],

(Backbone) ->
	class Release extends Backbone.Model
		url: 'data/releases.json'
);
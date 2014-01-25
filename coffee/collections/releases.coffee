define([
	'backbone',
	'models/release'
],

(Backbone, Release) ->
	class Releases extends Backbone.Collection
		model: Release

		url: 'data/releases.json'
);
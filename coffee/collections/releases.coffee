define (require, exports, module) ->
	Backbone = require('backbone')
	Release = require('models/release')

	class Releases extends Backbone.Collection
		model: Release

		url: 'api/releases'
define (require, exports, module) ->
	Backbone = require('backbone')

	class Release extends Backbone.Model
		url: 'api/releases'

		initialize: (slug) ->
			@url += "/#{slug}"
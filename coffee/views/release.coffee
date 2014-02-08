define (require, exports, module) ->
	$			= require('jquery')
	_			= require('underscore')
	Backbone 	= require('backbone')
	Release 	= require('models/release')

	class ReleaseView extends Backbone.View ->
		el: '.modal-content'

		render: (slug) ->
			release = new Release(slug)

			release.fetch success: (model, data) =>
				console.log model
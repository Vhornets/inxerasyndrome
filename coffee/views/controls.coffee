define([
	'jquery',
	'underscore',
	'backbone',
	'collections/releases',
	'text!templates/controls.tpl',
	'bootstrap'
],

($, _, Backbone, Releases, ControlsTpl) ->
	class ControlsView extends Backbone.View
		el: '.top-controls'

		events:
			'click .per-page>ul>li': 'changePerPage'

		initialize: (downloadsView) ->
			@DownloadsView = new downloadsView()

		changePerPage: (e) ->
			e.preventDefault()
			@DownloadsView.perPage = $(e.currentTarget).text()
			@DownloadsView.render()

		paginate: (data, page, perPage) ->
			data = _.rest(data, perPage * page)

			return data = _.first(data, perPage)
);
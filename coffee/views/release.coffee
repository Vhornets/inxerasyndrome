define (require, exports, module) ->
	$			= require('jquery')
	_			= require('underscore')
	Backbone 	= require('backbone')
	Release 	= require('models/release')
	ReleaseTpl 	= require('text!templates/release.tpl')

	class ReleaseView extends Backbone.View
		el: '.modal-content'

		render: (slug) ->
			release = new Release(slug)

			release.fetch success: (model, data) =>
				template = _.template(ReleaseTpl)
				data = @parseDbCells(data)
				@$el.find('.modal-body').html(template(release: data[0]))
				@$el.find('.modal-title').html("#{data[0].project} - #{data[0].title} (#{data[0].year})")
				$('#myModal').modal('show')

		parseDbCells: (data) ->
			_.each data, (release) ->
				release.images = $.parseJSON(release.images)
				release.links = $.parseJSON(release.links)
				release.tracklist = $.parseJSON(release.tracklist)
				release.playlists = $.parseJSON(release.playlists)

			return data				
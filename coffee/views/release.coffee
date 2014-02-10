define (require, exports, module) ->
	$					= require('jquery')
	_					= require('underscore')
	Backbone 			= require('backbone')
	Release 			= require('models/release')
	ReleaseTpl 			= require('text!templates/release.tpl')
	SoudcloudPlayerTpl 	= require('text!templates/soundcloud_player.tpl')

	class ReleaseView extends Backbone.View
		el: '.modal-content'

		render: (slug) ->
			release = new Release(slug)

			release.fetch success: (model, data) =>
				template = _.template(ReleaseTpl)
				data = @model.parseDbCells(data)

				@modal
					body: template(release: data[0])
					title: "#{data[0].project} - #{data[0].title} (#{data[0].year})"
						
		player: (playlist) ->
			template = _.template(SoudcloudPlayerTpl)
			@modal
				body: template(playlist: playlist, width: '100%', height: '450')

		modal: (content) ->
			@$el.find('.modal-body').html(content.body)
			@$el.find('.modal-title').html(if content.title then content.title else '')
			$('#myModal').modal('show')		
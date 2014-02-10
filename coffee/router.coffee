define (require, exports, module) ->
	Backbone 		= require('backbone')
	DownloadsView 	= require('views/downloads')
	ReleaseView		= require('views/release')
	Release 		= require('models/release')

	class Router extends Backbone.Router
		routes:
			'': 'showDownloads'
			'downloads/*slug': 'showRelease'
			'page/:page': 'renderPage'
			'play/*playlist': 'showPlayer'
			'filter/*filter': 'filterProjects'
			'*path': 'default'

		initialize: () ->
			@downloadsView = new DownloadsView(model: new Release)
			@releaseView = new ReleaseView(model: new Release)
			Backbone.history.start()

		showDownloads: () ->
			@downloadsView.render()

		showRelease: (slug) ->
			return @downloadsView.render() if not slug

			if @downloadsView.rendered
				@releaseView.render(slug)
			else
				@downloadsView.render()
				@releaseView.render(slug)

		renderPage: (page) ->
			@downloadsView.render(page - 1)

		showPlayer: (playlist) ->
			if @downloadsView.rendered
				@releaseView.player(playlist)
			else
				@releaseView.player(playlist)
				@downloadsView.render()

		filterProjects: (filter) ->
			@downloadsView.render(0, filter)

		default: (path)  ->
			@downloadsView.render()
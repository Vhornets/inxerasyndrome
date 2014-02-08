define (require, exports, module) ->
	Backbone 		= require('backbone')
	DownloadsView 	= require('views/downloads')
	#ReleaseView		= require('views/release')

	class Router extends Backbone.Router
		routes:
			'': 'showDownloads'
			'downloads/*slug': 'showRelease'
			'page/:page': 'renderPage'
			'play/*playlist': 'showPlayer'
			'filter/*filter': 'filterProjects'
			'*path': 'default'

		initialize: () ->
			@view = new DownloadsView()
			Backbone.history.start()

		showDownloads: () ->
			@view.render()

			# release = new ReleaseView()
			# release.render('medusa')			

		showRelease: (slug) ->
			return @view.render() if not slug
			@view.showRelease(slug)

		renderPage: (page) ->
			@view.render(page - 1)

		showPlayer: (playlist) ->
			@view.player(playlist)

		filterProjects: (filter) ->
			@view.render(0, filter)

		default: (path)  ->
			@view.render()
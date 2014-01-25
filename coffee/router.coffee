define([
	'backbone',
	'views/downloads'
],

(Backbone, DownloadsView) ->
	class Router extends Backbone.Router
		routes:
			'': 'showDownloads'
			'downloads/*name': 'showRelease'
			'page/:page': 'renderPage'
			'play/*playlist': 'showPlayer'
			'filter/*filter': 'filterProjects'
			'*path': 'default'

		initialize: () ->
			@view = new DownloadsView()
			Backbone.history.start();

		showDownloads: () ->
			@view.render()

		showRelease: (name) ->
			return @view.render() if not name
			@view.render(name)

		renderPage: (page) ->
			@view.render(false, page - 1)

		showPlayer: (playlist) ->
			@view.player(playlist)

		filterProjects: (filter) ->
			@view.render(false, 0, filter)

		default: (path)  ->
			@view.render()
);
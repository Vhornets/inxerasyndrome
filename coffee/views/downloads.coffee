define (require, exports, module) ->
	$ 					= require('jquery')
	_ 					= require('underscore')
	Backbone 			= require('backbone')
	cookies 			= require('utils/cookies')
	Releases 			= require('collections/releases')
	DownloadsTpl 		= require('text!templates/downloads.tpl')
	ReleaseTpl 			= require('text!templates/release.tpl')
	SoudcloudPlayerTpl 	= require('text!templates/soundcloud_player.tpl')
	BandcampPlayerTpl 	= require('text!templates/bandcamp_player.tpl')

	class DownloadsView extends Backbone.View
		el: '.content'

		events:
			'click .controls>a': 'toggleView'
			'click .per-page>li>a': 'changePerPage'
			'click .icon-play': 'showPlayer'

		initialize: () ->
			@perPage = 2
			@collection = new Releases()
			@template = ''

			@mainEvents()

		render: (page = 0, filter = false) ->
			@template = _.template(DownloadsTpl)

			@collection.url = 'api/releases'

			@collection.fetch success: (col, data) =>
				data = @parseDbCells(data)
				releases = if filter and filter != 'All' then _.where(data, {project: filter}) else data

				@$el.html(@template(
					releases: @paginate(releases, page, @perPage)
					pages: if releases.length / @perPage < 1.25 then 1 else Math.floor(releases.length / @perPage) + 1
					# Возвращает уникальные значения по полю projects
					projects: _.uniq data, true, (el) => el.project
					currentFilter: if filter then filter else 'All'
					perPage: @perPage
				))

				@$el
					.trigger('view:ready')
					.trigger('page:active', page)

		showRelease: (slug) ->
			@collection.url = "api/releases/#{slug}"

			@collection.fetch success: (model, data) =>
				data = @parseDbCells(data)
				@template = _.template(ReleaseTpl)
				#@render()

				@modal
					title: "#{data[0].project} - #{data[0].title} (#{data[0].year})"
					body: @template(release: data[0])

						
		player: (playlist) ->
			@template = _.template(SoudcloudPlayerTpl)
			@modal
				body: @template(playlist: playlist, width: '100%', height: '450')

		toggleView: (e) ->
			e.preventDefault()
			
			$currentControlBtn = $(e.currentTarget)

			cookies.set('cur-view-show', $currentControlBtn.attr('data-show'), {
				expires: 3600000
			});

			cookies.set('cur-view-hide', $currentControlBtn.attr('data-hide'), {
				expires: 3600000
			});

			@$el.trigger('view:ready')

		changePerPage: (e) ->
			e.preventDefault()
			@perPage = $(e.currentTarget).attr('data-perpage')
			@render()

		showPlayer: (e) ->
			e.preventDefault()

			$playerContainer = $(e.currentTarget).parent()

			playlist = $(e.currentTarget).attr('data-player')

			playerTpl = if $(e.currentTarget).attr('data-sc') then _.template(SoudcloudPlayerTpl) else _.template(BandcampPlayerTpl) 

			$playerContainer.html(playerTpl(playlist: playlist, width: '93%', height: '120'))

		paginate: (data, page, perPage) ->
			data = _.rest(data, perPage * page)

			return data = _.first(data, perPage)

		modal: (content) ->
			$('.modal-body').html(content.body)
			$('.modal-title').html(if content.title then content.title else '')
			$('#myModal').modal('show')

		mainEvents: () ->
			$(document).on 'hide.bs.modal', '#myModal', (e) ->
				if window.history.length > 2
					window.history.back() 
				else
					window.location.hash = ''
					#window.history.go(0)

			@$el
				.on 'view:ready', (e) ->
					$(cookies.get('cur-view-hide')).hide()
					$(cookies.get('cur-view-show')).show()
				.on 'page:active', (e, num) ->
					$('.page-num-'+(num+ 1)).addClass('active');
		# В таблице некоторые поля хранят значения в формате JSON
		# Метод парсит эти поля
		parseDbCells: (data) ->
			_.each data, (release) ->
				release.images = $.parseJSON(release.images)
				release.links = $.parseJSON(release.links)
				release.tracklist = $.parseJSON(release.tracklist)
				release.playlists = $.parseJSON(release.playlists)

			return data
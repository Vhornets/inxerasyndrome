define (require, exports, module) ->
	$ 					= require('jquery')
	_ 					= require('underscore')
	Backbone 			= require('backbone')
	cookies 			= require('utils/cookies')
	Releases 			= require('collections/releases')
	DownloadsTpl 		= require('text!templates/downloads.tpl')
	SoudcloudPlayerTpl 	= require('text!templates/soundcloud_player.tpl')
	BandcampPlayerTpl 	= require('text!templates/bandcamp_player.tpl')

	class DownloadsView extends Backbone.View
		el: '.content'

		events:
			'click .controls>a': 'toggleView'
			'click .per-page>li>a': 'changePerPage'

		initialize: () ->
			@perPage = 2
			@mainEvents()
			@rendered = false

		render: (page = 0, filter = false) ->
			releases = new Releases()
			template = _.template(DownloadsTpl)

			releases.fetch success: (col, data) =>
				data = @model.parseDbCells(data)
				releases = if filter and filter != 'All' then _.where(data, {project: filter}) else data
				@rendered = true

				@$el.html(template(
					releases: @paginate(releases, page, @perPage)
					pages: if releases.length / @perPage < 1.25 then 1 else Math.floor(releases.length / @perPage) + 1
					# Возвращает уникальные значения по полю projects
					projects: _.uniq data, true, (el) => el.project
					currentFilter: if filter then filter else 'All'
					perPage: @perPage
				))

				@$el.trigger('view:ready').trigger('page:active', page)

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

		paginate: (data, page, perPage) ->
			data = _.rest(data, perPage * page)

			return data = _.first(data, perPage)

		mainEvents: () ->
			$(document).on 'hide.bs.modal', '#myModal', (e) ->
				if window.history.length > 2
					window.history.back() 
				else
					window.location.hash = ''

			@$el
				.on 'view:ready', (e) ->
					$(cookies.get('cur-view-hide')).hide()
					$(cookies.get('cur-view-show')).show()
				.on 'page:active', (e, num) -> $('.page-num-'+(num+ 1)).addClass('active')
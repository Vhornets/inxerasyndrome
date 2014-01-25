define([
	'jquery',
	'underscore',
	'backbone',
	'utils/cookies',
	'collections/releases',
	'text!templates/downloads.tpl',
	'text!templates/release.tpl',
	'text!templates/player.tpl',
	'bootstrap'
],

($, _, Backbone, cookies, Releases, DownloadsTpl, ReleaseTpl, PlayerTpl) ->
	class DownloadsView extends Backbone.View
		el: '.content'

		events:
			'click .controls>a': 'toggleView'
			'click .per-page>li>a': 'changePerPage'
			#'click .project-filter>li>a': 'filterProjects'

		initialize: () ->
			@perPage = 2
			@collection = new Releases()
			@template = ''

		render: (name = false, page = 0, filter = false) ->
			@template = _.template(DownloadsTpl)

			@collection.fetch success: (col, data) =>
				releases = if filter && filter != 'All' then _.where(data.releases, {project: filter}) else data.releases

				@$el.html(@template(
					releases: @paginate(releases, page, @perPage)
					pages: if releases.length / @perPage < 1.25 then 1 else Math.floor(releases.length / @perPage) + 1
					# Возвращает уникальные значения по полю projects
					projects: _.uniq data.releases, true, (el) => el.project
					currentFilter: if filter then filter else 'All'
					perPage: @perPage
				))

				if name
					release = _.where(data.releases, {name: name})[0]

					@template = _.template(ReleaseTpl)

					@modal
						title: "#{release.project} - #{release.title} (#{release.year})"
						body: @template(release: release)						

				@$el
					.trigger('view:ready')
					.trigger('page:active', page)
						
		player: (playlist) ->
			@template = _.template(PlayerTpl)
			@modal
				body: @template(playlist: playlist)

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
			@perPage = $(e.currentTarget).text()
			@render()

		filterProjects: (e) ->
			e.preventDefault()
			filter = $(e.currentTarget).text()
			if filter == 'All' then @render(false, 0) else @render(false, 0, filter)


		paginate: (data, page, perPage) ->
			data = _.rest(data, perPage * page)

			return data = _.first(data, perPage)

		modal: (content) ->
			$('.modal-body').html(content.body)
			$('.modal-title').html(if content.title then content.title else '')
			$('#myModal').modal('show')				
);
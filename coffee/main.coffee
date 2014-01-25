require.config({
	baseUrl: '../js',

	paths: {
		text:			'vendor/text',
		jquery:			'vendor/jquery.min',
		underscore:		'vendor/underscore.min',
		backbone:		'vendor/backbone.min',
		bootstrap:		'vendor/bootstrap.min',
		templates:		'../templates',
		collections:	'./collections',
		models:			'./models',
		views:			'./views'
	}
});

define([
	'jquery',
	'utils/cookies',
	'./router'
],

($, cookies, Router) ->
	router = new Router()
	
	$(document).on 'hide.bs.modal', '#myModal', (e) ->
		if window.history.length > 2
			window.history.back() 
		else
			window.history.pushState({main: 'main'}, "Main Page", "/")
			window.history.go(0)

	$('.content')
		.on 'view:ready', (e) ->
			$('#loader').hide('slow')
			$(cookies.get('cur-view-hide')).hide()
			$(cookies.get('cur-view-show')).show()
		.on 'page:active', (e, num) ->
			$('.page-num-'+(num+ 1)).addClass('active');

);
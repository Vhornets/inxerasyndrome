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
	},

	shim: {
		bootstrap: {
			deps: ['jquery']
		}
	}
});

define (require, exports, module) ->
	$ 			= require('jquery')
	Router 		= require('./router')
	bootstrap 	= require('bootstrap')

	router = new Router()
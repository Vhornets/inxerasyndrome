define (require, exports, module) ->
	Backbone = require('backbone')

	class Release extends Backbone.Model
		url: 'api/releases'

		initialize: (slug) ->
			@url += "/#{slug}"
		# В таблице некоторые поля хранят значения в формате JSON
		# Метод парсит эти поля
		parseDbCells: (data) ->
			for num, release of data
				for key, val of release
					if @isJson(val)
						release[key] = JSON.parse(val)

			return data

		isJson: (str) ->
			try
				JSON.parse(str)
			catch e
				return false
			return true
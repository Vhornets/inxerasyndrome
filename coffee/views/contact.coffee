define (require, module, exports) ->
	Backbone 	= require('backbone')
	ContactTpl 	= require('text!templates/contact.tpl')

	class ContactView extends Backbone.View
		el: '.content'

		render: () ->
			@$el.html(ContactTpl)
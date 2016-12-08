$(document).on "page:load page:fetch page:ready turbolinks:load", ()->
	#esta linea es para arreglar la perdida de funciones js turbolinks:load
	componentHandler.upgradeDom()
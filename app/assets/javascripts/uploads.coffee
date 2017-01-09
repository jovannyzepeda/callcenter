# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "click", "#send_data",(ev)->
	$("#backspinner").removeClass "dispnone"
$(document).on "ajax:success","#uploads_forms", (e,data,estado,xhr)->
	$("#backspinner").addClass("dispnone")
	console.log e

$(document).on "ajax:error","#post_forms", (e,data,estado,xhr)->
	$("#backspinner").addClass("dispnone")
	console.log e
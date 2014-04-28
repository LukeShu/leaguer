json_url = "/alerts.json"

page_visited = false 
starting_size = 0
update = (alerts) ->
	if !page_visited
		starting_size = alerts.length
		page_visited = true

	if alerts.length > starting_size
		$("#alerts-ajax").css("display", "inline");
		return

	setTimeout (->
		$.ajax(url: json_url).done update
		return
	), 2000

# Now kick off the whole process
window.onload = ->
	$.ajax(url: json_url).done update
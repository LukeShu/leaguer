json_url = window.location.href.replace(/\.[^/]*$/,'')+".json"

page_visited_pms = false 
starting_size_pms = 0
update = (pms) ->
	if !page_visited_pms
		starting_size_pms = pms.conversation.count_messages
		page_visited_pms = true

	if pms.convesation.count_messages > starting_size_pms
		window.location.reload true
		return

	console.log("hey we got here!")
	console.log(starting_size_pms)
	console.log(pms.convesation.count_messages)

	setTimeout (->
		$.ajax(url: json_url).done update
		return
	), 2000

# Now kick off the whole process
window.onload = ->
	$.ajax(url: json_url).done update
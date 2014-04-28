json_url = window.location.href.replace(/\.[^/]*$/,'')+".json"

update = (tournament) ->
	here = tournament["players"].length
	needed = (tournament["min_teams_per_match"] * tournament["min_players_per_team"])
	pct_complete = here / needed

	$("#prog-bar").width (pct_complete * 100) + "%"
	$("#players-needed").text here + " " + ((if here is 1 then "player has" else "players have")) + " signed up. " + needed + " players needed. "

	# Update the user list
	players = ""
	for player in tournament["players"]
		players = players + "<li>"+player["user_name"]+"</li>"
	$("#tournament-users").html players

	# Enable/disable the "start" button depending on the number of players
	$("input[value=\"Start Tournament\"]").prop "disabled", (if (pct_complete >= 1) then false else true)

	# Switch views if the tournament has been started
	if tournament["status"] is 1
		window.location.reload true

	# Do it all again
	setTimeout (->
		$.ajax(url: json_url).done update
		return
	), 2000

# Now kick off the whole process
window.onload = ->
	$.ajax(url: json_url).done update

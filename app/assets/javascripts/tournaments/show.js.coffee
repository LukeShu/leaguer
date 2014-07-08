# Copyright (C) 2014 Andrew Murrell
# Copyright (C) 2014 Davis Webb
# Copyright (C) 2014 Guntas Grewal
# Copyright (C) 2014 Luke Shumaker
# Copyright (C) 2014 Nathaniel Foy
# Copyright (C) 2014 Tomer Kimia
#
# This file is part of Leaguer.
#
# Leaguer is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Leaguer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the Affero GNU General Public License
# along with Leaguer.  If not, see <http://www.gnu.org/licenses/>.

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

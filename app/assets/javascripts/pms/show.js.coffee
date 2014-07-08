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
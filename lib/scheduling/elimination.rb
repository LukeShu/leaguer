
module Scheduling
	class Elimination
		include Rails.application.routes.url_helpers

		def initialize(tournament_stage)
			@tournament_stage = tournament_stage
		end

		def tournament_stage
			@tournament_stage
		end
		def tournament
			self.tournament_stage.tournament
		end

		def create_matches
			num_teams = (self.tournament.players.count/self.tournament.min_players_per_team).floor
			num_matches = num_teams - 1
			for i in 1..num_matches
				self.tournament_stage.matches.create(status: 0, submitted_peer_evaluations: 0)
			end
			match_num = num_matches-1
			team_num = 0
			# for each grouping of min_players_per_team
			self.tournament.players.each_slice(self.tournament.min_players_per_team) do |team_members|
				# if the match is full, move to the next match, otherwise move to the next team
				if (team_num == self.tournament.min_teams_per_match)
					match_num -= 1
					team_num = 0
				else
					team_num += 1
				end
				# create a new team in the current match
				self.tournament_stage.matches[match_num].teams.push(Team.create(users: team_members))
			end
		end

		def match_finished(match)
			matches = match.tournament_stage.matches_ordered
			cur_match_num = matches.invert[match]
			unless cur_match_num == 1
				match.winner.matches.push(matches[cur_match_num/2])
			end
		end

		def graph(current_user)
			matches = @tournament_stage.matches_ordered
			# depth of SVG tree
			depth = Math.log2(matches.count).floor+1;
			# height of SVG
			height = [200 * 2**Math.log2(matches.count).floor + 100, 500].max;
			lastrx = 0
			lastry = 0
			lastrh = 0
			lastrw = 0

			str = <<-STRING
<svg version="1.1" baseProfile="full"
     xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     width="100%" height="#{height}">
	<defs>
		<radialGradient id="gradMatch" cx="50%" cy="50%" r="80%" fx="80%" fy="80%">
			<stop offset="0%" style="stop-color:#ffd281; stop-opacity:0" />
			<stop offset="100%" style="stop-color:#ccc;stop-opacity:1" />
		</radialGradient>
	</defs>
STRING
			(1..matches.count).each do |i|
				rh = 100/(2**(depth-1)+1) - 5
				rw = 100/(depth+1) - 5
				rx = 50/(depth+1) + 100/(depth+1)*(depth-(Math.log2(i).floor+1))
				ry = ( 100/(2**(Math.log2(i).floor)+1) + rh * 1.1 * (2**Math.log2(i).ceil-i))

				str += "\t<a id=\"svg-match-#{i}\" xlink:href=\"#{match_path(matches[i])}\"><g>\n"
				str += "\t\t<rect height=\"#{rh}%\" width=\"#{rw}%\" x=\"#{rx}%\" y=\"#{ry}%\" fill=\"url(#gradMatch)\" rx=\"5px\" stroke-width=\"2\""
				case matches[i].status
				when 0
					if matches[i].teams.count < @tournament_stage.tournament.min_teams_per_match
						str += ' stroke="red"'
						str += ' fill-opacity="0.6"'
					else
						str += ' stroke="green"'
					end
				when 1
					str += ' stroke="orange"'
				when 2
					str += ' stroke="yellow"'
				when 3
					str += ' stroke="grey"'
				end
				str += "/>\n"

				color = matches[i].teams.first and matches[i].teams.first.users.include?(current_user) ? "#BCED91" : "white"
				str += "\t\t<rect width=\"#{rw-5}%\" height=\"#{rh/4}%\" x=\"#{rx + 2.5}%\" y=\"#{ry + rh/6}%\" fill=\"#{color}\" />\n"
				if matches[i].teams.first
					str += "\t\t<text x=\"#{rx + rw/4}%\" y=\"#{ry + rh/3}%\" font-size=\"#{rh}\">Team #{matches[i].teams.first.id}</text>\n"
				end

				str += "\t\t<text x=\"#{rx + 1.3*rw/3}%\" y=\"#{ry + 5.2*rh/9}%\" font-size=\"#{rh}\"> VS </text>\n"

				color = matches[i].teams[1] and matches[i].teams[1].users.include?(current_user) ? "#BCED91" : "white"
				str += "\t\t<rect width=\"#{rw-5}%\" height=\"#{rh/4}%\" x=\"#{rx + 2.5}%\" y=\"#{ry + 3*rh/5}%\" fill=\"#{color}\" />\n"
				if matches[i].teams[1]
					str += "\t\t<text x=\"#{rx + rw/4}%\" y=\"#{ry + 4*rh/5}%\" font-size=\"#{rh}\">Team #{matches[i].teams[1].id}</text>\n"
				end

				if i > 1
					str += "\t\t<line x1=\"#{rx+rw}%\" y1=\"#{ry+rh/2}%\" x2=\"#{lastrx}%\" y2=\"#{lastry+lastrh/2}%\" stroke=\"black\" stroke-width=\"2\" >\n"
				end
				if Math.log2(i+1) == Math.log2(i+1).ceil
					lastrx = rx
					lastry = ry
					lastrh = rh
					lastrw = rw
				end
				str += "</g></a>\n"
			end
			str += '</svg>'

			return str
		end
	end
end

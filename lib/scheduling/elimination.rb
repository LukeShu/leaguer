
module Scheduling
	class Elimination
		include Rails.application.routes.url_helpers

		def initialize(tournament_stage)
			@tournament_stage = tournament_stage
		end

		def create_matches
			num_teams = (tournament.players.count/tournament.min_players_per_team).floor
			num_matches = (Float(num_teams -  tournament.min_teams_per_match)/(tournament.min_teams_per_match - 1)).ceil + 1
			for i in 1..num_matches
				tournament_stage.matches.create(status: 0, submitted_peer_evaluations: 0)
			end

			match_num = num_matches-1
			team_num = 0

			tournament.players.shuffle

			# for each grouping of min_players_per_team
			tournament.players.each_slice(tournament.min_players_per_team) do |team_members|
				# if the match is full, move to the next match, otherwise move to the next team
				if (team_num == tournament.min_teams_per_match)
					match_num -= 1
					team_num = 1
				else
					team_num += 1
				end
				# create a new team in the current match
				tournament_stage.matches[match_num].teams.push(Team.create(users: team_members))
			end
		end

		def match_finished(match)
			#what in the goddamn fuck does this mean
			matches = match.tournament_stage.matches_ordered
			cur_match_num = matches.invert[match]
			unless cur_match_num == 1
				match.winner.matches.push(matches[cur_match_num/2])
			end
		end

		def graph(current_user)
			matches = @tournament_stage.matches_ordered
			numTeams = @tournament_stage.tournament.min_teams_per_match
			logBase = numTeams
			
			# depth of SVG tree
			depth = Math.log(matches.count*(logBase-1),logBase).floor+1;
			
			# height of SVG
			matchHeight = 50*logBase;
			height = [(matchHeight+50) * logBase**(depth-1) + 100, 500].max;

			str = <<-STRING
<svg version="1.1" baseProfile="full"
     xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     width="100%" height="#{height}">
	<defs>
		<radialGradient id="gradMatch" cx="50%" cy="50%" r="80%" fx="50%" fy="50%">
			<stop offset="0%" style="stop-color:#fff; stop-opacity:1" />
			<stop offset="100%" style="stop-color:#ccc;stop-opacity:0" />
		</radialGradient>
	</defs>
STRING
			base = 1
			pBase = 1
			(1..matches.count).each do |i|
				matchDepth = Math.log(i*(logBase-1), logBase).floor+1
				puts matchDepth
				if matchDepth > Math.log(base*(logBase-1), logBase).floor+1
					pBase = base
					base = i
				end
				puts base
				rh = 100 / (logBase**(depth-1)+1) - 100/height;
				puts rh
				rw = 100/(depth+1) - 5
				puts rw
				rx = 50/(depth+1) + 100/(depth+1)*(depth-matchDepth)
				puts rx
				ry = 100/(logBase**(matchDepth-1)+1) * (i-base+1) - rh/2
				puts ry

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

				t = 1
				while t <= numTeams
					color = (matches[i].teams[t-1] and matches[i].teams[t-1].users.include?(current_user)) ? "#5BC0DE" : "white"
					str += "\t\t<rect width=\"#{rw-5}%\" height=\"#{rh*Float(30)/(matchHeight)}%\" x=\"#{rx + 2.5}%\" y=\"#{ry + (Float(t-1)/numTeams)*rh + 1 }%\" fill=\"#{color}\" />\n"
					if matches[i].teams[t-1]
						str += "\t\t<text x=\"#{rx + rw/4}%\" y=\"#{ry + (Float(t-1)/numTeams + Float(33)/(matchHeight))*rh}%\" font-size=\"200%\">Team #{matches[i].teams[t-1].id}</text>\n"
					end
					if (t < numTeams)
						str += "\t\t<text x=\"#{rx + 1.3*rw/3}%\" y=\"#{ry + (Float(t)/numTeams)*rh + 1}%\" font-size=\"200%\"> VS </text>\n"
					end
					t = t + 1
				end

				if i > 1
					parent = (i+logBase-2)/logBase
					pDepth = Math.log(parent*(logBase-1), logBase).floor+1
					lastrx = 50/(depth+1) + 100/(depth+1)*(depth-pDepth)
					lastry = 100/(logBase**(pDepth-1)+1) * (parent-pBase+1) - rh/2
					str += "\t\t<line x1=\"#{rx+rw}%\" y1=\"#{ry+rh/2}%\" x2=\"#{lastrx}%\" y2=\"#{lastry+rh/2}%\" stroke=\"white\" stroke-width=\"2\" >\n"
				end
				str += "</g></a>\n"
			end
			str += '</svg>'

			return str
		end

		private

		def tournament_stage
			@tournament_stage
		end

		def tournament
			tournament_stage.tournament
		end
	end
end

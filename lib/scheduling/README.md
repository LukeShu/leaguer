Files in this directory should implement the following interface:

 - `initialize(tournament_stage)`
	construct new Scheduling object from tournament_stage

 - `create_matches`
 	creates all the matches of the current round

 - `finish_match(match)`
 	progresses the match through the schedule

 - `graph`
 	returns a string representation of an svg image of the current stage
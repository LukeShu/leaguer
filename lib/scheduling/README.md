Scheduling interface
====================

Files in this directory should be _classes_ implementing the following
interface:

 - `initialize(TournamentStage)`

   Construct new Scheduling object from tournament_stage.

 - `create_matches`

   Creates all the matches of the current round.

 - `finish_match(Match)`

   Progresses the match through the schedule.

 - `graph`

   Returns a string representation of an svg image of the current
   stage.

Scoring interface
=================

Files in this directory should be _modules_ implementing the following
interface:

 - `stats_needed() => Array[i]=Symbol`

   Returns which statistics need to be collected for this scoring
   algorithm.

 - `score(match) => Hash[User]=Integer`

   User scores for this match, assuming statistics have been
   collected.

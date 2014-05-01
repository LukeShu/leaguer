---
title: "Team 6 - Project Leaguer: Sprint 2 Retrospective"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# Tasks

The "size" is using the modified Fibonacci scale.  A '1' is expected
to take less than an hour.  A '3' is expected to take 3-6 hours.  A
'5' should take the better part of a day or two.  An 8 should take
several days.

+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Working                           | Size | Person\*   | US |
+=========================================================+======+============+====+
| [Intelligent Error Handling](#error-hand)               |   3  | Andrew     | 3  |
+---------------------------------------------------------+------+------------+----+
| [Search](#search)                                       |   5  | Tomer      | 6  |
+---------------------------------------------------------+------+------------+----+
| [Remote Game UserNames](#remote_user)                   |   3  | Davis      | 12 |
+---------------------------------------------------------+------+------------+----+
| [Email verification](#email-varify)                     |   8  | Luke       | 2  |
+---------------------------------------------------------+------+------------+----+
| [Alternate Scoring and pairing methods](#alt-score-par) |   5  | G, A, D    | 7,8|
+---------------------------------------------------------+------+------------+----+
| [Tournament preference interface](#tourn-prefer)        |   3  | Andrew     | 9  |
+---------------------------------------------------------+------+------------+----+
| [More types of seeded settings](#seed)                  |   2  | Andrew     | 9  |
+---------------------------------------------------------+------+------------+----+
| [Asynchronous Riot Pulls](#async)                       |   5  | Nathaniel  | 11 |
+---------------------------------------------------------+------+------------+----+
| [Map out brackets scaffolding](#brack-scaff)            |   5  | Tomer      | 10 |
+---------------------------------------------------------+------+------------+----+
| [Create braket creation and submission gui](#brack-gui) |   3  | Tomer      | 10 |
+---------------------------------------------------------+------+------------+----+
| [General Interface Cleanups](#interface-cleean)         |   2  | Tomer      | 1  |
+---------------------------------------------------------+------+------------+----+
| [Make it look professional](#professional)              |   3  | All        | 1  |
+---------------------------------------------------------+------+------------+----+
| [Expand Peer Evaluation](#peer-expansion)               |   3  | G, A, D    | 7  |
+---------------------------------------------------------+------+------------+----+
| [Private Messages](#priv-messages)                      |   5  | N, L       | 5  |
+---------------------------------------------------------+------+------------+----+
| [Alerts](#alerts)                                       |   3  | Guntas     | 4  |
+---------------------------------------------------------+------+------------+----+
| [Project Leaguer Logo](#logo)                           | spike| G, D       | 1  |
+---------------------------------------------------------+------+------------+----+




+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Not Working Well                  | Size | Person\*   | US |
+=========================================================+======+============+====+

## Remote Game UserNames (#remote_user)

	The idea behind remote usernames is that a Leaguer user would be able to add
a username from another online service to our database (such as add their riot
username to our database) so that information from that outer source could be used
in our tournament statistics.  This is constructed by adding a reference to the user
to the remote_username column of the SQL database and giving it a value. This value
is a hash that can contain any sort of information needed. 

## Project Leaguer Logo (#logo))

	The point of the Leaguer logo is to set a definitive symbol for our product.  The
current logo is a rough draft and will more than likely not be truly done for some time
if ever.  For now, we have a decent looking logo and are planning on placing it into the
product documents.  Other than that, this is not yet complete.

## More types of seeded settings (#seed)

The idea behind the seeding settings is have different methods of team 
creation.  The seeding methods we have currently are:
	I.  Early bird
		- Which is the method of creating a team based on who joins the 
		tournament first.  So if there are five players per team, then 
		the first five players to join the tournament would be on team
		one and so on. 

	II.  Random 
		- Which will take an array of the players and shuffle them, as 
		to randomize their order, and then place them in teams based on the 
		maximum team size. So the first five in team one, the next five in 
		team two, and so on.

	III.  Fair Ranked
		- Which will place users of a tournament into teams based on their
		skill level.  This will ensure the five best players of a tournament
		are not on the same team, as to allow fair gameplay.

Early bird and random seeding are  completed, but fair ranked has yet
to be done. 

+---------------------------------------------------------+------+------------+----+
| Tasks Not Implemented                                   | Size | Person\*   | US |
+=========================================================+======+============+====+
TODO





# Implemented and working

## Intelligent Error Handling (#error-hand)

TODO

## Search (#search)


TODO

## Email verification (#email-varify)

TODO

## Alternate Scoring and pairing methods (#alt-score-par)

TODO

## Tournament preference interface (#tourn-prefer)

TODO





TODO

## Asynchronous Riot Pulls (#async)

TODO

## Map out brackets scaffolding (#brack-scaff)

TODO

## Create braket creation and submission gui (#brack-gui)

TODO

## General Interface Cleanups (#interface-cleean)

TODO

## Make it look professional (#professional)

TODO

## Expand Peer Evaluation (#peer-expansion)

TODO

## Private Messages (#priv-messages)

TODO

## Alerts (#alerts)

TODO


# Implemented but not working well

TODO



# Not implemented

TODO



# How to improve

TODO

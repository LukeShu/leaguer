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
TODO




+---------------------------------------------------------+------+------------+----+
| Tasks Not Implemented                                   | Size | Person\*   | US |
+=========================================================+======+============+====+
TODO




# Implemented and working

## Intelligent Error Handling (#error-hand)

TODO

## Search (#search)

Search was given its own controller, and a static page callled "go.html.erb". The 
search controller essentially took the query, and made an SQL call to the users
database and the tournaments dadtabase. We've moved the tournament and player
display methods so that the search would display players and tournaments in the same
way that they've been displaying in their respective "index.html.erb" page. Advanced
search was added so that users could search tournaments by their game type.

## Remote Game UserNames (#remote_user)

TODO

## Email verification (#email-varify)

TODO

## Alternate Scoring and pairing methods (#alt-score-par)

TODO

## Tournament preference interface (#tourn-prefer)

TODO

## More types of seeded settings (#seed)

TODO

## Asynchronous Riot Pulls (#async)

TODO

## Map out brackets scaffolding (#brack-scaff)

Brackets are structures that have a users' prediction of the winners of a 
tournaments matches. Essentially, a tournament has many brackets, each bracket has
a user that creates it, and each bracket has bracket-matches that correspond to the
matches of the tournament the bracket belongs to. Bracket matches are only models, 
as the user should be able to predit all winners from a single view that belongs to
a bracket. Brackets on the other hand have a model, controller, and views, so that
users may create, edit, and view them.

## Create braket creation and submission gui (#brack-gui)

The bracket creation gui looks simple to the user, but does a lot on the backend.
When the user presses "Make a bracket" on a tournament, a bracket is created based
on the user, the tournament, and the tournament's matches. The bracket's submission
GUI looks a lot like an elimination tournament's SVG, however the user is able to
click on teams to advance them forward. The SVG has javascript functions that both
advance the teams visually on the SVG, and write the user's prediction in a hidden
form. When the user clicks submit, the predictions are saved in the bracket's 
matches.

## General Interface Cleanups (#interface-cleean)

There was a generaly lack of consistency within the color scheme of the website by
the end of sprint 2. Since e-sport players often spend hours in front of screens, it
was important to reduce eye strain by making our interface dark while keeping it
sleek and modern. We've also chosen to stick to a small pallette color within the wrapper
div of the pages.

## Make it look professional (#professional)

TODO

## Expand Peer Evaluation (#peer-expansion)

TODO

## Private Messages (#priv-messages)

TODO

## Alerts (#alerts)

TODO

## Project Leaguer Logo (#logo))

TODO



# Implemented but not working well

TODO



# Not implemented

TODO



# How to improve

TODO

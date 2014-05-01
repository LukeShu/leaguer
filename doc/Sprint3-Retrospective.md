---
title: "Team 6 - Project Leaguer: Sprint 3 Retrospective"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# Tasks

The "size" is using the modified Fibonacci scale.  A '1' is expected
to take less than an hour.  A '3' is expected to take 3-6 hours.  A
'5' should take the better part of a day or two.  An 8 should take
several days.

+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Working                           | Size | Person     | US |
+=========================================================+======+============+====+
| [Intelligent Error Handling](#error-hand)               |   3  | Andrew     | 3  |
+---------------------------------------------------------+------+------------+----+
| [Search](#search)                                       |   5  | Tomer      | 6  |
+---------------------------------------------------------+------+------------+----+
| [Remote Game UserNames](#remote_user)                   |   3  | Davis      | 12 |
+---------------------------------------------------------+------+------------+----+
| [Email verification](#email-verify)                     |   8  | Luke       | 2  |
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
| [General Interface Cleanups](#interface-clean)          |   2  | Tomer      | 1  |
+---------------------------------------------------------+------+------------+----+
| [Make it look professional](#professional)              |   3  | All        | 1  |
+---------------------------------------------------------+------+------------+----+
| [Private Messages](#priv-messages)                      |   5  | N, L       | 5  |
+---------------------------------------------------------+------+------------+----+
| [Alerts](#alerts)                                       |   3  | Guntas     | 4  |
+---------------------------------------------------------+------+------------+----+
| [Project Leaguer Logo](#logo)                           | spike| G, D       | 1  |
+---------------------------------------------------------+------+------------+----+




+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Not Working Well                  | Size | Person     | US |
+=========================================================+======+============+====+
| [Expand Peer Evaluation](#peer-expansion)               |   3  | G, A, D    | 7  |
+---------------------------------------------------------+------+------------+----+




+---------------------------------------------------------+------+------------+----+
| Tasks Not Implemented                                   | Size | Person     | US |
+=========================================================+======+============+====+
TODO




# Implemented and working

## Intelligent Error Handling (#error-hand)

Several important cases for error redirection were handled via standard permissions
changes and in the end only a few specific redirections needed to be coded directly
(such as correctly handling redirections away from a destoryed tournament or match).

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

We overhaulted the entire tournament structure and introduced a modular/pluggable
system for seeding, scheduling, sampling, and scoring, lovingly called the 4S Module
System.  We relocated code from other places into these modules in the 'lib'
directory including form HTML which is retrieved dynamically from these modules.
In the case of sampling (retrieving and populating statistics for scoring) we built
an intelligent system for populating available modules for a game-type based on the
statistics needed for its scoring methods which replaced their manual configuration.
We introduced Tournament Stages to accomodate a wider range of tournament types
and modes and designed the library modules to be general enough to use results of
past stages or player statistics to affect future ones.

## Tournament preference interface (#tourn-prefer)

TODO

## More types of seeded settings (#seed)

TODO

## Asynchronous Riot Pulls (#async)

Project Leaguer handles asynchronous API pulling with the Delayed Job gem. A
separate daemons server runs concurrently in order to use this functionality.
The algorithm for Riot API pulling makes sure that the server does not go over the
limited number of pulls set by Riot (no more than 10 per 10 seconds and 500 in ten
minutes). It auto-grabs data for a League of Legends match by comparing games from
a user in the match every four minutes. When their last match data changes, we know
to then grab the rest of the data for the match.

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

## General Interface Cleanups (#interface-clean)

Project Leaguer better handled tournament interface in this iteration. Tournaments
are listed more cleanly on the index page. Each game type has an icon listed with
it to better identify different game types on the index page. Each tournament's
host's gravatar is also listed on the index page. Creating a tournament itself is
also cleaner. Customization categories are clearly separated and use the correct
selection or input types for easy use.

## Make it look professional (#professional)

The team decided on a color scheme for Leaguer during this sprint. This scheme
was applied to every page in the site. Since e-sport players often spend hours in
front of screens, it was important to reduce eye strain by making our interface dark
while keeping it sleek and modern. We implemented Gravatar in a few more spots as
well, helping to distinguish between users more easily. The default image was
changed to give each user a unique avatar even if they've not set one. Tournament
creation and listing also received tune ups, with images listed with each tournament
to help display its game type and a better creation page when creating a tournament.

## Private Messages (#priv-messages)

Private Messsaging in Project Leaguer is possible between two registered users.
Project Leaguer uses the gem 'Mailboxer' to achieve private messaging. A user
is able to interact with the private messaging system by clicking on the "Messages"
located in the header toolbar at the top of every page. This results in the index
page, which lists all unread and read conversations. You can then click on a 
conversation to view all of its messages and from there you can also reply.
Creating a new message is as simple as: click the "start a new conversation",
list the user you wish to pm with, write the conversation's subject, and write
the message itself.

## Alerts (#alerts)

The alerts system was implemented with the help of the 'Mailboxer' gem which 
is the same as the private message system. The Alert system was made available to
anyone who had permissions to create an alert and all users were notified when an 
alert was created with a live update, a pop up notification which redirects to the
list of alerts, in the navigation bar of the recieving users. The alerts icon 
appeared only when there is a new alert. 

## Project Leaguer Logo (#logo))

TODO



# Implemented but not working well

## Expand Peer Evaluation (#peer-expansion)

We created a scoring modules for users to select the preferred scoring method and 
preferred peer evaluation for users to choose from when creating a tournament.
The peer evaluation modules calculate the score correctly but do not grab the 
statistics from the submission forms. The skeletons for three such scoring methods 
namely, winnerTakesAll, FibonacciPeerWithBlowout, MarginalPeer, have been created.
The for MarginalPeer we do not have a view but we do have the methods that would 
calculate the score provided the stats are in the database. For WinnerTakesAll and
FibonacciWithPeerBlowout we do have views and data being collected from the interface
and used to calculate score.


# Not implemented

TODO



# How to improve

TODO

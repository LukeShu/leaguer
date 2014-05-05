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
| [Email verification](#email-verify)                     |   8  | Luke       | 2  |
+---------------------------------------------------------+------+------------+----+
| [Alternate Scoring and pairing methods](#alt-score-par) |   5  | G, A, D    | 7,8|
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
| [Expand Peer Evaluation](#peer-expansion)               |   3  | G, A, D    | 7  |
+---------------------------------------------------------+------+------------+----+
| [Private Messages](#priv-messages)                      |   5  | N, L       | 5  |
+---------------------------------------------------------+------+------------+----+
| [Alerts](#alerts)                                       |   3  | Guntas     | 4  |
+---------------------------------------------------------+------+------------+----+


+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Not Working Well                  | Size | Person     | US |
+=========================================================+======+============+====+
| [Remote Game UserNames](#remote_user)                   |   3  | Davis      | 12 |
+---------------------------------------------------------+------+------------+----+
| [Tournament preference interface](#tourn-prefer)        |   3  | Andrew     | 9  |
+---------------------------------------------------------+------+------------+----+
| [More types of seeded settings](#seed)                  |   2  | Andrew     | 9  |
+---------------------------------------------------------+------+------------+----+
| [Project Leaguer Logo](#logo)                           | spike| G, D       | 1  |
+---------------------------------------------------------+------+------------+----+


+---------------------------------------------------------+------+------------+----+
| Tasks Not Implemented                                   | Size | Person     | US |
+=========================================================+======+============+====+
| [Nothing cause we are great](#success)                  | 0    | ---        | 0  |
+---------------------------------------------------------+------+------------+----+


# [How to improve](#improve)



# Implemented and working

## Intelligent Error Handling (#error-hand)

Several important cases for error redirection were handled via standard permissions
changes and in the end only a few specific redirections needed to be coded directly
(such as correctly handling redirections away from a destoryed tournament or match).

## Search (#search)

A basic SearchController and simple view were implemented.  The search controller
took the query, and queried the "name" columns in the user and tournament database
tables.  An "advanced" search mode allows filtering tournaments by game type.  We
would like to be able to search based on other parameters and settings of the
tournament, and other user attributes.

To more easily render the search results, we moved the tournament and player
display blocks from their respective index pages to be shared, to display them
consistently, and avoid code duplication.

## Email verification (#email-varify)

Email verification was (finally) implemented.  It uses delayed_job
(see [asynchronous Riot pulls](#async)) to avoid blocking the page if
the MX isn't responding.  However, email password resets are not yet
implemented, which is the obvious use-case for verified emails.

## Alternate Scoring and pairing methods (#alt-score-par)

We overhaulted the entire tournament structure and introduced a modular/pluggable
system for seeding, scheduling, sampling, and scoring, lovingly called the 4S-Module
System.  We relocated code from other places into these modules in the 'lib'
directory including form HTML which is retrieved dynamically from these modules.
In the case of sampling (retrieving and populating statistics for scoring) we built
an intelligent system for populating available modules for a game-type based on the
statistics needed for its scoring methods which replaced their manual configuration.
We introduced Tournament Stages to accomodate a wider range of tournament types
and modes and designed the library modules to be general enough to use results of
past stages or player statistics to affect future ones.

## More types of seeded settings (#seed)

We implemented seeding for initial placement of players within a tournament as part
of the 4S-Module System. Three seeding modules were implemented.

	I.  Early bird
		- Team rosters are based on order of registration for the tournament.

	II.  Random
		- Team rosters are randomized.

	III.  Fair Ranked
		- Players are distributed evenly on teams according to their performance in
		the previous tournament stage. This method only works for tournaments with
		multiple stages.

## Asynchronous Riot Pulls (#async)

Prior to this iteration, calls to the Riot Games API here hard-coded, and blocked
the page from loading while the requests were made.  We needed to (1) create an
interface for doing this flexibly (2) make the calls asynchrounous to avoid blocking
the page load.  To perform the asynchronous requets, we used the "delayed_job" gem
to run each request as a separate job process.  A challenge with this was that most
API's (including Riot Games') place an artifical limit on API requests within a
given period of time (in the case of Riot Games, 10 requests per 10 seconds, and
500 per 10 minutes).  So the background job making requests must be throttled from
making too many within several given rolling blocks of unit time.  To do this,
we implemented a ThrottledApiRequest base class that makes it simple to create
throttled asynchronous API requests, which we used to create the "RiotAPI" sampling
method, but is applicable in a much wider variety of situations.

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

Project Leaguer better handled tournament interface in this iteration.  Tournaments
are listed more cleanly on the index page.  Each game type has an icon listed with
it to better identify different game types on the index page.  Each tournament's
host's gravatar is also listed on the index page.  Creating a tournament itself is
also cleaner.  Customization categories are clearly separated and use the correct
selection or input types for easy use.

## Make it look professional (#professional)

The team decided on a color scheme for Leaguer during this sprint. This scheme
was applied to every page in the site. Since e-sport players often spend hours in
front of screens, it was important to reduce eye strain by making our interface dark
while keeping it sleek and modern. We implemented Gravatar in a few more spots as
well, helping to distinguish between users more easily.  he default image was
changed to give each user a unique avatar even if they've not set one. Tournament
creation and listing also received tune ups, with images listed with each tournament
to help display its game type and a better creation page when creating a tournament.

## Expand Peer Evaluation (#peer-expansion)

We created a scoring modules for users to select the preferred scoring method and 
preferred peer evaluation for users to choose from when creating a tournament.
The peer evaluation modules calculate the score correctly and grab the 
statistics from the submission forms. The skeletons for three such scoring methods 
namely, winnerTakesAll, FibonacciPeerWithBlowout, MarginalPeer, have been created.
For the MarginalPeer we do not have a view but we do have the methods that would 
calculate the score provided the stats are in the database. For WinnerTakesAll and
FibonacciWithPeerBlowout we do have views and data being collected from the interface
and used to calculate score.

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

# Implemented but not working well

## Expand Peer Evaluation (#peer-expansion)

We created scoring modules for users to select the preferred scoring method,
including options for peer review, during tournament creation. We created three
scoring modules: winnerTakesAll, FibonacciPeerWithBlowout, and MarginalPeer, two
of which work. Since winnerTakesAll and FibonacciPeerWithBlowout demonstrated the
extremes, the testing of MarginalPeer was considered low priority. As a whole the
scoring modules' interface, outlined in the 4S-Module README for scoring was
designed much better than than our implementations were able to show off by the
end of the sprint.

## Remote Game UserNames (#remote_user)

Project Leaguer stores for each user and game-type a reference to a remote username.
This allows a user to register her accounts with the system and for API requests to
be completed for a registered game-type. The interface for this was only partially
completed, and being integrated into a player's profile page directly, it only
allowed registration of League of Legends remote usernames.

## Project Leaguer Logo (#logo))

While a suitable logo was created, it was deemed too unprofessional for use by the
project at this time. The search for a more amicable logo remains underway.

## Tournament preference interface (#tourn-prefer)

Tournament Settings are handled correctly and securely, the permission system is
robust enough to handle custom preferences, the database structure exists to
handle them, and even the icons for adding them were created, however, the interface
for adding them was deemed low priority for this sprint in comparison to the lib
modules and permissions overhauls.

# Not implemented

We implemented everything we planned to implement and much more.

# How to improve (#improve)

1. In this sprint our primary mistake was in planning. We were too nonspecific in
deciding what to get done and accepted too many tasks as essential. We should have
scaled down our efforts and focused on only the most essential tasks. In the future,
more time will be spent on designing and planning sprints and dividing workload.

2. Also because of last-minute alterations and refactors, nearly EVERYTHING that
could have gone wrong in our presentation went wrong (the wifi connectivity dropped,
our presentation server on demo.projectleaguer.net wasn't updating, even Andrew's
window manager segfaulted). Much of this could have been fixed if we simply a little
better prepared and had frozen our codebase a specified time prior to the
presentation. Realistically, things would have worked phenomenally better had we
another few hours to prepare for the presentation. In the future when presenting to
potential users or stakeholders we will be sure to have a practiced presentation to
match the polished codebase which will then be able to speak for itself.

3. We can better plan our project's flow and layout. We refactored a lot of code in
this sprint because different methods didn't work together as we thought they would.
We spent a lot of time reworking things that should have already been complete
simply because of incomptability issues; the transitions between steps in our flow
didn't function as we intended. Moving forward, we have more time to ensure that
components work together properly and are tested in a more
comprehensive manner.

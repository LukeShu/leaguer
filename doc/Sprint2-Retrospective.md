---
title: "Team 6 - Project Leaguer: Sprint 2 Retrospective"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# User Stories

1) As a user, I would like intelligent error handling and 404 redirection.

2) As a user, I would like a working search utility.

3) As a player, I would like a way to enter my usernames for several different remote games.

4) As an admin I would like an option and utility to require email verification for users.

5) As a host, I would like to have multiple options for scoring.

6) As a host, I would like to have multiple tournament structures and types for pairing and running tournaments.

7) As a host, I would like to have an interface for adding tournament-specific preferences.

8) As a host, I would like to allow a wider variety of kinds of settings to be set.

9) As a user, I would like the Riot API to be asynchronously polled in the background so League of Legends tournaments proceed automatically.

10) As a user, I would like to view and create brackets.

11) As a user, I would like the web interface to look more professional.

12) As a host or player, I would like a larger set of peer evaluation settings.

# Tasks

The "size" is using the modified Fibonacci scale.  A '1' is expected
to take less than an hour.  A '3' is expected to take 3-6 hours.  A
'5' should take the better part of a day or two.  An 8 should take
several days.

+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Working                           | Size | Person\*   | US |
+=========================================================+======+============+====+
| [Define Specific Unit Tests for Security]               |    3 | All        |  1 |
| (#security-test)                                        |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Implement Anti-spam measures](#anti-spam)              |    2 | Davis      |  2 |
+---------------------------------------------------------+------+------------+----+
| [Implement Teammate Rating System (peer review view)]   |    5 | Guntas     |  3 |
|  (#peer-review)                                         |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Design/Code Scoring/Pairing Algorithms and Procedures] |    5 | D+F+A      |  3 |
| (#pair-alg)                                             |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Implement game-type specific and tournament            |    8 | L+A+G      |  4 |
| specific settings and preferences] (#setting-and-pref)  |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Retrieve data from Riot Games (TM) API ](#riot-api)    |    3 | Foy        |  5 |
+---------------------------------------------------------+------+------------+----+
| [Parse Riot data and attach to scoring subsystem]       |    5 | Davis      |  5 |
| (#parse-riot)                                           |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Teach Andrew and Tomer AJAX ](#teach-ajax)             |    2 | Luke       |  6 |
+---------------------------------------------------------+------+------------+----+
| [Make pages auto-update with AJAX](#ajax)               |    5 | T+A        |  6 |
+---------------------------------------------------------+------+------------+----+
| [Setting up a Tournament View for matches and tree]     |    5 | Tomer      |  7 |
| (#match-gui)                                            |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Increase Usability](#usability)                        |    3 | All-L      |  8 |
+---------------------------------------------------------+------+------------+----+
| [Develop comprehensive data storage for s&p&other]      |    5 | L+A        |  9 |
| (#data-storage)                                         |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Create Player Profile Pages](#profile)                 |    2 | Tomer      | 10 |
+---------------------------------------------------------+------+------------+----+
| [Gravatar Integration](#gravatar)                       |    2 | Foy        | 10 |
+---------------------------------------------------------+------+------------+----+




+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Not Working Well                  | Size | Person\*   | US |
+=========================================================+======+============+====+
| [Not Applicable](#all-or-nothing)                       |    0 | ---        | 0  |
+---------------------------------------------------------+------+------------+----+




+---------------------------------------------------------+------+------------+----+
| Tasks Not Implemented                                   | Size | Person\*   | US |
+=========================================================+======+============+====+
| [Email Verification Option](#email-varify)              |    5 | Luke       |  2 |
+---------------------------------------------------------+------+------------+----+
| [Project Leaguer Logo](#logo)                           | spike| D+G        |  8 |
+---------------------------------------------------------+------+------------+----+




# Implemented and working

## Define Specific Unit Tests for Security   {#security-test}
## Implement Anti-spam measures {#anti-spam}   
## Implement Teammate Rating System (peer review view) {#peer-review}
## Design/Code Scoring/Pairing Algorithms and Procedures {#pair-alg}
## Implement game-type specific and tournament specific settings and preferences
   {(#setting-and-pref)}

## Retrieve data from Riot Games (TM) API {#riot-api}

Grabbing League of Legends user and match data from Riot's servers has been
implemented using their newly available API. A developer key is necessary in
order to retrieve data from their servers. We currently are using Davis's to do
so. Information is grabbed with HTTParty.get and the correct url.  A hash of 
information is stored this way. Grabbing information for a user requires the 
user's League of Legends summoner's name or summoner id. Our current developer
key is limited to utilizing 10 pulls per 10 seconds.

## Parse Riot data and attach to scoring subsystem {#parse-riot}

We successfully parse the data we recieve from the Riot servers. The information
is stored in a JSON hash which we separate based on the information we want (like 
kills, deaths, etc).  One issue with our current pull method is that it can exceed
the pull limit that is on our current development key.  To fix this, we are planning
on implementing a remote user id to link users Leaguer information to their Riot
information.

## Teach Andrew and Tomer AJAX {#teach-ajax}

Luke instructed Tomer on his AJAX tasks, but most of Andrew's were deferred to
sprint 3 and he focused his efforts elsewhere.

## Make pages auto-update with AJAX  {#ajax}

AJAX was used in tournament and match views to update the tournament progress bar
and manage input options for tournament flow but still needs to be implemented 
across the website in other areas.

## Setting up a Tournament View for matches and tree {#match-gui}



## Increase Usability  {#usability}

Project Leaguer has many new features that have increased usability. AJAX
integration, tournament visuals (ready bar, match trees), Gravatar images, 
and Riot API integration all contribute towards an easier and more automatic
web interface available for our users to utilize.

## Develop comprehensive data storage for s&p&other{#data-storage}

Settings and Preferences (those options specific to tournaments of a game type
or a specific tournament, respectively) are handled through a single
TournamentPreference SQL (ActiveRecord) interface.

## Create Player Profile Pages {#profile}

Player Profile Pages successfully list important and useful user information.
Player username, e-mail, relationship status, and recent tournament information
are all listed on a user's profile page. Gravatar images are also shown here.
Users can also edit their pages.

## Gravatar Integration {#gravatar}

Gravatar images are fetched from the gravatar website. A user's e-mail is used to
generate a hash key and that key is used to grab their gravatar image from a url.
If their e-mail is not recognized by Gravatar, then we have a wide number of 
optionable default images to use. We currently use a mystery man default. It's
also possible to utilize a number of other image options, such as sizing.



# Implemented but not working well

## Not Applicable (#all-or-nothing)

Everything we implemented was implemented well, or else we didn't implement it.


# Not implemented

## Email Verification Option (#email-verify)

This was not implemented for lack of time. Luke probably would have been able to
implement it with his time constraints if he wasn't busy frequently assisting
other members with various problems. In the end, the email verification was also
simply a low priority.

## Project Leaguer Logo {#logo} 

The Project Leaguer Logo was discussed before the sprint started. We decided we
would follow up on any opportunities to explore creating a Leauger Logo, but this
simply did not happen. We greatly want one, but it's still just a low priority
extra feature.

# How to improve

Our biggest fault this time around was the lack of motivation before spring break.
Our commits slowed to a halt the week before spring break.

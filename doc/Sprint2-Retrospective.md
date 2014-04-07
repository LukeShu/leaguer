---
title: "Team 6 - Project Leaguer: Sprint 2 Retrospective"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# User Stories

1) As an admin, I would like hosts/players, to have only the options
   their group entitles them to.

2) As an admin, I would like anti-spam measures for registration.

3) As a player I would like to review my peers and have our
   scores reflect these reviews.

4) As a host I would like to have both game-type specific settings and
   tournament specific preferences available when creating a new
   tournament.
    - These settings and preferences were moved to sprint 2 from sprint 1
      because we did not have the API functionality for any specific game yet.

5) As a host/player/spectator I would like to have Riot Games League
   of Legends API integration for match and player statistics and results for
   League of Legends tournaments.

6) As a host/player, I would like my pages to actively update without
   refreshing my current page.
    - For this task, we will implement an Active Status Update system with AJAX.

7) As a host/player, I would like to see an interactive tournament lobby page
   that displays tournament and match information.
    - This will be accomplished with dynamic graphs, trees, and status bars.

8) As a host/player, I would like the Leaguer application to be more intuitive
   and easy to use.

9) As a user, I would like past tournament and player information to be
   persistent and search-able.
    - A working search utility should be implemented that will find specific
      players or tournaments and return their pages.

10) As a user, I would like to see Player Profile pages.
    - For this task, we will be creating profile pages for registered users that
      have player-specific information such as tournament history and activity.

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
| Implement game-type specific and tournament             |    8 | L+A+G      |  4 |
| specific settings and preferences                       |      |            |    |
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
## Implement Anti-spam measures {#email-varify}   
## Implement Teammate Rating System (peer review view) {#peer-review}
## Design/Code Scoring/Pairing Algorithms and Procedures {#pair-alg}
## Implement game-type specific and tournament specific settings and preferences {}
## Retrieve data from Riot Games (TM) API {#riot-api}
## Parse Riot data and attach to scoring subsystem {#parse-riot}
## Teach Andrew and Tomer AJAX {#teach-ajax}
## Make pages auto-update with AJAX  {#ajax}
## Setting up a Tournament View for matches and tree {#match-gui}
## Increase Usability  {#usability}
## Develop comprehensive data storage for s&p&other{#data-storage}

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
## Project Leaguer Logo {#logo} 


# How to improve

Our biggest fault this time around was the lack of motivation before spring break.
Our commits slowed to a halt the week before spring break.

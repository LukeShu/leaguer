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
| Task Description                                        | Size | Person\*   | US |
+=========================================================+======+============+====+
| [Define Specific Unit Tests for Security](#security-test)               |    3 | All        |  1 |
+---------------------------------------------------------+------+------------+----+
| [Implement Anti-spam measures](#anti-spam)          |    2 | Davis      |  2 |
+---------------------------------------------------------+------+------------+----+
| [Email Verification Option](#email-varify)              |    5 | Luke       |  2 |
+---------------------------------------------------------+------+------------+----+
| [Implement Teammate Rating System (peer review view)](#peer-review)     |    5 | Guntas     |  3 |
+---------------------------------------------------------+------+------------+----+
| [Design/Code Scoring/Pairing Algorithms and Procedures](#pair-alg)   |    5 | D+F+A      |  3 |
+---------------------------------------------------------+------+------------+----+
| Implement game-type specific and tournament             |    8 | L+A+G      |  4 |
| specific settings and preferences                       |      |            |    |
+---------------------------------------------------------+------+------------+----+
| [Retrieve data from Riot Games (TM) API ](#riot-api)    |    3 | Foy        |  5 |
+---------------------------------------------------------+------+------------+----+
| [Parse Riot data and attach to scoring subsystem](#parse-riot)         |    5 | Davis      |  5 |
+---------------------------------------------------------+------+------------+----+
| [Teach Andrew and Tomer AJAX ](#teach-ajax)             |    2 | Luke       |  6 |
+---------------------------------------------------------+------+------------+----+
| [Make pages auto-update with AJAX](#ajax)               |    5 | T+A        |  6 |
+---------------------------------------------------------+------+------------+----+
| [Setting up a Tournament View for matches and tree](#match-gui) |    5 | Tomer      |  7 |
+---------------------------------------------------------+------+------------+----+
| [Increase Usability](#usability)                        |    3 | All-L      |  8 |
+---------------------------------------------------------+------+------------+----+
| [Project Leaguer Logo](#logo)                           | spike| D+G        |  8 |
+---------------------------------------------------------+------+------------+----+
| [Develop comprehensive data storage for s&p&other](#data-storage)     |    5 | L+A        |  9 |
+---------------------------------------------------------+------+------------+----+
| [Create Player Profile Pages](#profile)                 |    2 | Tomer      | 10 |
+---------------------------------------------------------+------+------------+----+
| [Gravitar Integration](#gravitar)                       |    2 | Foy        | 10 |
+---------------------------------------------------------+------+------------+----+
| [Test it](#test)                                        |    1 | All-L      | all|
+---------------------------------------------------------+------+------------+----+
| [Peer review](#peer)                                    |    1 | All        | all|
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
## Project Leaguer Logo {#logo}   
## Develop comprehensive data storage for s&p&other{#data-storage}
## Create Player Profile Pages {#profile}    
## Gravitar Integration {#gravitar}    
## Test it {#test}
## Peer review  {#peer}


# Implemented but not working well


# Not implemented



# How to improve


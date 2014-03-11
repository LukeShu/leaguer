---
title: "Team 6 - Project Leaguer: Sprint 2"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# User Stories

1) As an admin, I would like hosts/players, to have only the options
   their group entitles them to.

2) As an admin, I would like anti-spam measures for registration.

2) As a player I would like to review my peers and like to have our scores reflect these reviews.

Peer Review

3) As a host I would like to have both game type specific settings and tournament specific preferences available when creating a new tournament.

Settings/Preferences

4) As a host/player spectator I would like to have Riot Games League of Legends API integration. 

LoL API Integration

5) As a host/player, I would like my pages to actively update without
   refreshing my current page.
   	- For this task, we will implent an Active Status Update system with AJAX.

6) As a host/player, I would like to see an interactive tournament lobby page
   that displays tournament information and its matches.

7) As a host/player, I would like the Leaguer application to be more intuitive
   and easy to use.

8) As a user, I would like past tournament and player information to be 
   persistent and searchable.
   	- A working search bar should be implemented that will find specific
   	  players or tournaments and return their pages.

9) As a user, I would like Player Profile pages.
	- For this task, we will be creating profile pages for registered users
	  that have player-specific information: name, tournament history, etc.

# Tasks

The "size" is using the modified Fibonacci scale.  A '1' is expected
to take less than an hour.  A '3' is expected to take 3-6 hours.  A
'5' should take the better part of a day or two.  An 8 should take
several days.

+---------------------------------------------------------+------+--------+----+
| Task Description                                        | Size | Person | US |
+=========================================================+======+========+====+
| Define Specific Unit Tests for Security                 |    3 | All    |  1 |
+---------------------------------------------------------+------+--------+----+
| Implement Anti-spam measures                            |    2 | Davis  |  1 |
+---------------------------------------------------------+------+--------+----+
| Gravitar Integration                                    |    2 | Foy    |  1 |
+---------------------------------------------------------+------+--------+----+
| ProjectLeaguer Logo                                     | spike| D&G    |  7 |
+---------------------------------------------------------+------+--------+----+
| Email Verification Option                               |    5 | Luke   |  1 |
+---------------------------------------------------------+------+--------+----+
| Implement Teammate Rating System (peer review view)     |    5 | Guntas |  2 |
+---------------------------------------------------------+------+--------+----+
| Design/Code Scoring/Pairing Algorithms and Procedures   |    5 | D&F&A  |  3 |
+---------------------------------------------------------+------+--------+----+
| Implement gametype specific and tournament              |    8 | Luke&A |  3 |
| specific settings and preferences                       |      | Guntas |    |
+---------------------------------------------------------+------+--------+----+
| Retrieve data from Riot Games (TM) API                  |    3 | Foy    |  4 |
+---------------------------------------------------------+------+--------+----+
| Parse Riot data and attach to scoring subsystem         |    5 | Davis  |  4 |
+---------------------------------------------------------+------+--------+----+
| Teach Andrew and Tomer AJAX                             |    2 | Luke   |  5 |
+---------------------------------------------------------+------+--------+----+
| Make pages auto-update with AJAX                        |    5 | T&A    |  5 |
+---------------------------------------------------------+------+--------+----+
| Setting up a Tournament View for matches and tree       |    5 | Tomer  |  6 |
+---------------------------------------------------------+------+--------+----+
| Increase Usability                                      |    3 | All-L  |  7 |
+---------------------------------------------------------+------+--------+----+
| Develop comprehensive data storage for s&p&other        |    5 | Luke&A |  8 |
+---------------------------------------------------------+------+--------+----+
| Create Player Profile Pages                             |    2 | Tomer  |  4 |
+---------------------------------------------------------+------+--------+----+
| Test it                                                 |    1 | All-L  |  2 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+

Total Size of Iteration: 55

D - 10
A - 10
F - 10
G - 10
L - 11
T - 10

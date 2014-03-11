---
title: "Team 6 - Project Leaguer: Sprint 1 Retrospective"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# User Stories

1) As an administrator, I would like to install and boot my own server.
    - Alternately: As a developer, I would like a demo/testing server,
      with a basic Rails setup.
2) As a host/player, I would like to register and have an account.
    - For this task, we will be creating the user registration and log
      in capabilities for Leaguer.
3) As a host, I would like to start a tournament.
    - For this task, we will be creating a base tournament system for a
      host to run.
4) As a host/player, I would like to enter scores for players.
    - For sprint own, the scores will be entered by hand.
5) As an administrator, I want to specify how users become hosts.
6) As a user I would like to see the progress of the tournament in my
   browser.
7) As a user, I would like a presentable homepage.
    - For this task, we will be creating a Leaguer homepage and ensure that it
      is pleasing to the eye and easy to navigate.

# Tasks

The "size" is using the modified Fibonacci scale.  A '1' is expected
to take less than an hour.  A '3' is expected to take 3-6 hours.  A
'5' should take the better part of a day or two.  An 8 should take
several days.

+---------------------------------------------------------+------+--------+----+
| Tasks Implemented and Working                           | Size | Person | US |
+=========================================================+======+========+====+
| [Learn Rails, set up Scaffolding for all Models, Views, |    8 | All    |  1 |
| Controllers](#learn-rails)                              |      |        |    |
+---------------------------------------------------------+------+--------+----+
| [Deploy rails on Luke's server](#deploy-rails)          |    3 | Luke   |  1 |
+---------------------------------------------------------+------+--------+----+
| [Create log-in system back-end (verification, cookies,  |    5 | Davis  |  2 |
| and redirection)](#login-backend)                       |      |        |    |
+---------------------------------------------------------+------+--------+----+
| [Create log-in system UI](#login-ui)                    |    2 | Tomer  |  2 |
+---------------------------------------------------------+------+--------+----+
| [Create Tournament Settings Page](#tourney-settings)    |    3 | Guntas |  3 |
+---------------------------------------------------------+------+--------+----+
| [Implement Tournament Registration and Tournament       |    2 | Andrew |  3 |
| Controller](#tourney-registration)                      |      |        |    |
+---------------------------------------------------------+------+--------+----+
| [Implement match controller](#match-controller)         |    3 | Dav+And|  4 |
+---------------------------------------------------------+------+--------+----+
| [Implement permissions system over the users            |    3 | Luke   |  5 |
| system](#permissions)                                   |      |        |    |
+---------------------------------------------------------+------+--------+----+
| [Create View Tournament Page](#tourney-view)            |    5 | All    |  6 |
+---------------------------------------------------------+------+--------+----+
| [Create Presentable Homepage](#homepage)                |    5 | Guntas |  7 |
+---------------------------------------------------------+------+--------+----+


+---------------------------------------------------------+------+--------+----+
| Tasks Implemented and Not Working Well                  | Size | Person | US |
+=========================================================+======+========+====+
| [Design and implement match score models](#match-score) |    3 | Foy    |  4 |
+---------------------------------------------------------+------+--------+----+
| [Create Admin-level Server Management Page](#srv-man)   |    2 | Luke   |  5 |
+---------------------------------------------------------+------+--------+----+


+---------------------------------------------------------+------+--------+----+
| Tasks Not Implemented                                   | Size | Person | US |
+=========================================================+======+========+====+
| [Design/Code Scoring/Pairing Algorithms and             |    5 | Foy    |  3 |
| Procedures](#score-algo)                                |      |        |    |
+---------------------------------------------------------+------+--------+----+
| [Observe Foy Design/Code Scoring/Pairing                |    2 | Dav+Foy|  3 |
| Algorithms](#score-algo)                                |      |        |    |
+---------------------------------------------------------+------+--------+----+
| [Create a Player-level Data Entry Page/Method for       |    3 | Tomer  |  4 |
| Results](#data-entry)                                   |      |        |    |
+---------------------------------------------------------+------+--------+----+

# Implemented and working

## Learn Rails {#learn-rails}

Learning Rails has been a growing experience for the majority of the
team. Some of us coming from no significant experience to being able
to put together a relatively functional product in only three weeks
has been an impressive journey.

## Deploy Rails {#deploy-rails}

The entire team became familiar with deploying Rails in our rather
diverse working environments and successfully deployed a server
instance located at demo.projectleaguer.net.

## Login (back-end) {#login-backend}

Our login back-end successfully logs users in and our and can handle
user registrations and first-come-first-serve uniqueness validation.

## Login (UI) {#login-ui}

Our login user interface successfully differentiates between logged in
and logged out users as well as between users of different
designations (although for the demo some of the hooks were not in
place, this has been fixed).

## Tournament settings {#tourney-settings}

## Tournament registration {#tourney-registration}

## Match controller {#match-controller}

## Permissions system {#permissions}

## Tournament view {#tourney-view}

## Homepage {#homepage}

# Implemented but not working well

## Match score models {#match-score}
This only functioned properly for noting which team would win a match. We want
more information to be included, such as individual player scores.  We also
only had it working where the tournament host would decide who won.

## Server management {#srv-man}



# Not implemented

## Scoring Algorithms {#score-algo}

Scoring algorithms was not implemented because we did not have time for 
implementing player statistics in the first sprint.  There were some
preliminary approaches, but the task lost priority and was abandoned.

## Data entry {#data-entry}

It was decided to not be a priority for sprint one due to time constraints. 
Also, we want to implement data entry for League of Legends through 
Riot Games (TM)'s API for grabbing match data.

# End

1. Each task must be mentioned under the right category (implemented
   and working, implemented but did not work well, or not implemented
   and the team must mention why/how it worked or why/how did not
   work: 3.5 points ( - 1.0) for each unmentioned task, ( - 0.5) for
   each task that is not properly described or placed under the wrong
   category.

2. How to improve: Please mention at least 3 ways  about  how to
   improve your work.  - 0.5 for each  missing point. (Total: 1.5
   points)

3. For the tasks that were not implemented or did not work well, the
   team should implement or fix these as necessary in the next
   Sprint. We will use this Retrospective document in the next Demo
   Meeting.

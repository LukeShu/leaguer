---
title: "Sprint 1 Retrospective"
author: [ Team 6: Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# User Stories

1) As an administrator, I would like to install and boot my own server.
   - Alternately: As a developer, I would like a demo/testing server,
     with a basic Rails setup.
2) As a host/player, I would like to register and have an account.
   - For this task, we will be creating the user registration and log
     in capabilities for Leaguer.
3) As a host, I would like to start a tournamnet.
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
| Controllers](#1)                                        |      |        |    |
+---------------------------------------------------------+------+--------+----+
| Deploy rails on the server at 199.180.255.147           |    3 | Luke   |  1 |
+---------------------------------------------------------+------+--------+----+
| Create log-in system backend (verification, cookies,    |    5 | Davis  |  2 |
| and redirection)                                        |      |        |    |
+---------------------------------------------------------+------+--------+----+
| Create log-in system UI (forms, CSS, and submission)    |    2 | Tomer  |  2 |
+---------------------------------------------------------+------+--------+----+
| Create Preliminary Tournament Settings Page             |    3 | Guntas |  3 |
+---------------------------------------------------------+------+--------+----+
| Implement Tournament Registration and Tournament        |    2 | Andrew |  3 |
| Controller                                              |      |        |    |
+---------------------------------------------------------+------+--------+----+
| Implement match controller                              |    3 | Dav+And|  4 |
+---------------------------------------------------------+------+--------+----+
| Implement permissions system over the users system      |    3 | Luke   |  5 |
+---------------------------------------------------------+------+--------+----+
| Create View Tournament Page                             |    5 | All    |  6 |
+---------------------------------------------------------+------+--------+----+
| Create Presentable Homepage                             |    5 | Guntas |  7 |
+---------------------------------------------------------+------+--------+----+


+---------------------------------------------------------+------+--------+----+
| Tasks Implemented and Not Working Well                  | Size | Person | US |
+=========================================================+======+========+====+
| Design and implement match score models                 |    3 | Foy    |  4 |
+---------------------------------------------------------+------+--------+----+
| Create Admin-level Server Management Page               |    2 | Luke   |  5 |
+---------------------------------------------------------+------+--------+----+


+---------------------------------------------------------+------+--------+----+
| Tasks Not Implemented                                   | Size | Person | US |
+=========================================================+======+========+====+
| Design/Code Scoring/Pairing Algorithms and Procedures   |    5 | Foy    |  3 |
+---------------------------------------------------------+------+--------+----+
| Observe Foy Design/Code Scoring/Pairing Algorithms      |    2 | Dav+Foy|  3 |
+---------------------------------------------------------+------+--------+----+
| Create a Player-level Data Entry Page/Method for Results|    3 | Tomer  |  4 |
+---------------------------------------------------------+------+--------+----+

Link to [text](#target)

[label]: #target

[Learn Rails]: #1


1. Each task must be mentioned under the right category (implemented and working, implemented but did not work well, or not implemented and the team must mention why/how it worked or why/how did not work: 3.5 points
( - 1.0) for each unmentioned task, ( - 0.5) for each task that is not properly described or  placed under the wrong category. 

2.  How to improve: Please mention at least 3 ways  about  how to improve your work.  -  0.5 for each  missing point. (Total: 1.5 points)  

3.  For the tasks that were not implemented or did not work well, the  team  should implement or fix  these as necessary in the next Sprint. We will use this Retrospective document in the next Demo  Meeting.
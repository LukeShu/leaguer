---
title: "Project Leaguer: Sprint 1"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
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
| Task Description                                        | Size | Person | US |
+=========================================================+======+========+====+
| Learn Rails, set up Scaffolding for all Models, Views,  |    8 | All    |  1 |
| Controllers                                             |      |        |    |
+---------------------------------------------------------+------+--------+----+
| Deploy rails on the server at 199.180.255.147           |    3 | Luke   |  1 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+
| Create log-in system backend (verification, cookies,    |    5 | Davis  |  2 |
| and redirection)                                        |      |        |    |
+---------------------------------------------------------+------+--------+----+
| Create log-in system UI (forms, CSS, and submission)    |    2 | Tomer  |  2 |
+---------------------------------------------------------+------+--------+----+
| Test it                                                 |    1 | Foy    |  2 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  2 |
+---------------------------------------------------------+------+--------+----+
| Create Preliminary Tournament Settings Page             |    3 | Guntas |  3 |
+---------------------------------------------------------+------+--------+----+
| Design/Code Scoring/Pairing Algorithms and Procedures   |    5 | Foy    |  3 |
+---------------------------------------------------------+------+--------+----+
| Observe Foy Design/Code Scoring/Pairing Algorithms      |    2 | Dav+Foy|  3 |
+---------------------------------------------------------+------+--------+----+
| Implement Tournament Registration and Tournament        |    2 | Andrew |  3 |
| Controller                                              |      |        |    |
+---------------------------------------------------------+------+--------+----+
| Test it                                                 |    1 | Andrew |  2 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+
| Design and implement match score models                 |    3 | Foy    |  4 |
+---------------------------------------------------------+------+--------+----+
| Implement match controller                              |    3 | Dav+And|  4 |
+---------------------------------------------------------+------+--------+----+
| Create a Player-level Data Entry Page/Method for Results|    3 | Tomer  |  4 |
+---------------------------------------------------------+------+--------+----+
| Test it                                                 |    1 | Andrew |  2 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+
| Implement permissions system over the users system      |    3 | Luke   |  5 |
+---------------------------------------------------------+------+--------+----+
| Create Admin-level Server Management Page               |    2 | Luke   |  5 |
+---------------------------------------------------------+------+--------+----+
| Test it                                                 |    1 | Tomer  |  2 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+
| Create View Tournament Page                             |    5 | All    |  6 |
+---------------------------------------------------------+------+--------+----+
| Test it                                                 |    1 | All    |  2 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+
| Create Presentable Homepage                             |    5 | Guntas |  7 |
+---------------------------------------------------------+------+--------+----+
| Peer review                                             |    1 | All    |  1 |
+---------------------------------------------------------+------+--------+----+

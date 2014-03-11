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
instance located at demo.projectleaguer.net as well as on our local boxes.

## Login (back-end) {#login-backend}

Our login back-end successfully logs users in and our and can handle
user registrations and first-come-first-serve uniqueness validation.

## Login (UI) {#login-ui}

Our login user interface successfully differentiates between logged in
and logged out users as well as between users of different
designations (although for the demo some of the hooks were not in
place, this has been fixed).

## Tournament settings {#tourney-settings}
<<<<<<< HEAD

Tournament settings were implemented at a basic level, instituting those
items which are similar to all tournaments, regardless of type, orginating
from the game model.

=======
  
>>>>>>> 5f96d780def7c33a6d6e452b558ac136ee4d06bc
## Tournament registration {#tourney-registration}

Tournament registration and the tournament contoller were completed which
allowed users to join and participate in basic tournaments of several types.
The tournament controller handled a variety of tournament related tasks,
including creating and updating tournaments and validating tournament related
operations.

## Match controller {#match-controller}

The Match Controller creates the separate matches for a specific tournament.
When a tournament is started, it begins with an initial match that contains
no players.  Currently, a player must join a match by entering the specific
tournament (by clicking the 'show' button on the tournament), 
then they must enter the match (again by clicking the 'show' button but this
time on the match they desire to participate in) and then finally clicking
the 'join' button.  This updates the match with the user as a participant in
the matc and then finally clicking the 'join' button.  This updates the match
with the user as a participant in the match.  A match can also be destroyed 
by clicking the 'delete' button on the no longer desired match on the page.

## Permissions system {#permissions}

## Tournament view {#tourney-view}
The view page for tournaments contains a table that lists all on going 
tournaments for all types of games. It also lists other game attribute like
Players per team, Teams per match, whether or not teams were randomized 
and also has links to Show, Edit, Destroy, Join a particular tournament. 
A link to create a tournament is also provided. Each of the links correspond 
to view pages which are html.erb pages that provide styles and functionality 
of each of the tournament setting features. Show, Edit, Destroy, all have 
views of their own to perform each of the above actions.

The tournament view lists the tournaments on one page as a table of rows. Each
row lists sample tournament information (game name, players per team, etc)
along with buttons for different tasks, such as joining or viewing a tourny.
You can also create a new tournament here. The functionality we want is
here.

## Homepage {#homepage}
The homepage is mainly controlled by the views that are associated with each 
model and controller. The main view for the homepage is the one found in the 
layouts called application.html.erb, this view is responsible for display of
all the headings, navigation bars, forms and containers. This view page 
contains mostly links to other view pages and yields whatever the other view
pages have to offer. The Homepage redirects to Login, Signup, See Ongoing
Tournaments and shows the view for those models.


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

# How to improve

Peer reviews and testing were our biggest pitfalls.


1. All testing was just manual, in-browser testing, rather than unit
   tests.  We really need write unit tests this iteration, as we had
   breakages where we said "this is exactly why we need unit
   testing."  However, that happened late enough in the iteration that
   we didn't have time to do anything about it.

2. That leads us into time management. Our commit activity plotted
   against time has humps each weak, each growing a little.  That is,
   we started slow, and ended with a lot of work.  This wasn't exactly
   poor planing, but we had a poor idea of how much time things would
   take.  We plan to fix this by front-loading this iteration instead
   of back-loading it.

3. We had the approach of "show everyone everything" with peer
   reviews, as we anticipated that this would be nescessary for
   everyone learning Rails.  However, in effect it meant that
   sometimes information was spread very thin, or because things were
   being done "in the open", we didn't ever explicitly review them.
   We plan on fixing this next iteration by committing to do very
   specific peer reviews with just a couple members of the team.

---
title: "Team 6 - Project Leaguer: Sprint 2 Retrospective"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

# Tasks

The "size" is using the modified Fibonacci scale.  A '1' is expected
to take less than an hour.  A '3' is expected to take 3-6 hours.  A
'5' should take the better part of a day or two.  An 8 should take
several days.

+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Working                           | Size | Person\*   | US |
+=========================================================+======+============+====+
| [Intelligent Error Handling](#error-hand)               |   3  | Andrew     | 3  |
+---------------------------------------------------------+------+------------+----+
| [Search](#search)                                       |   5  | Tomer      | 6  |
+---------------------------------------------------------+------+------------+----+
| [Remote Game UserNames](#remote_user)                   |   3  | Davis      | 12 |
+---------------------------------------------------------+------+------------+----+
| [Email verification](#email-varify)                     |   8  | Luke       | 2  |
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
| [General Interface Cleanups](#interface-cleean)         |   2  | Tomer      | 1  |
+---------------------------------------------------------+------+------------+----+
| [Make it look professional](#professional)              |   3  | All        | 1  |
+---------------------------------------------------------+------+------------+----+
| [Expand Peer Evaluation](#peer-expansion)               |   3  | G, A, D    | 7  |
+---------------------------------------------------------+------+------------+----+
| [Private Messages](#priv-messages)                      |   5  | N, L       | 5  |
+---------------------------------------------------------+------+------------+----+
| [Alerts](#alerts)                                       |   3  | Guntas     | 4  |
+---------------------------------------------------------+------+------------+----+
| [Project Leaguer Logo](#logo)                           | spike| G, D       | 1  |
+---------------------------------------------------------+------+------------+----+




+---------------------------------------------------------+------+------------+----+
| Tasks Implemented and Not Working Well                  | Size | Person\*   | US |
+=========================================================+======+============+====+
TODO




+---------------------------------------------------------+------+------------+----+
| Tasks Not Implemented                                   | Size | Person\*   | US |
+=========================================================+======+============+====+
TODO




# Implemented and working

## Intelligent Error Handling (#error-hand)

Several important cases for error redirection were handled via standard permissions
changes and in the end only a few specific redirections needed to be coded directly
(such as correctly handling redirections away from a destoryed tournament or match).

## Search (#search)

TODO

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

TODO

## Map out brackets scaffolding (#brack-scaff)

TODO

## Create braket creation and submission gui (#brack-gui)

TODO

## General Interface Cleanups (#interface-cleean)

TODO

## Make it look professional (#professional)

TODO

## Expand Peer Evaluation (#peer-expansion)

TODO

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

TODO

## Project Leaguer Logo (#logo))

TODO



# Implemented but not working well

TODO



# Not implemented

TODO



# How to improve

TODO

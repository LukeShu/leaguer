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
| [General Interface Cleanups](#interface-clean)         |   2  | Tomer      | 1  |
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

TODO

## Search (#search)

TODO

## Remote Game UserNames (#remote_user)

TODO

## Email verification (#email-varify)

TODO

## Alternate Scoring and pairing methods (#alt-score-par)

TODO

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

## General Interface Cleanups (#interface-clean)

TODO

## Make it look professional (#professional)

The team decided on a color scheme for Leaguer during this sprint. This scheme
was applied to every page in the site. We implemented Gravatar in a few more
spots as well, helping to distinguish between users more easily. The default
image was changed to give each user a unique avatar even if they've not set one.
Tournament creation and listing also received tune ups, with images listed with
each tournament to help display its game type and a better creation page when
creating a tournament.

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

The alerts system was implemented with the help of the Mailboxer gem which 
is the same as the personal message system. The Alert system was made available to anyone
who had permissions to create an alert and all users were notified when an alert
was created with live update, a pop up notification which redirects to the list of alerts,
in the navigation bar of the recieving users. The alerts icon appered only when there is a 
new alert. 

## Project Leaguer Logo (#logo))

TODO



# Implemented but not working well

TODO



# Not implemented

TODO



# How to improve

TODO

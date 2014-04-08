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
| [Define Specific Unit Tests for Security]               |    3 | All        |  1 |
| (#security-test)                                        |      |            |    |
+---------------------------------------------------------+------+------------+----+




# Implemented and working

## Implement Anti-spam measures {#anti-spam}

To handle potential spam problems, Project Leaguer has implemented Simple Captcha
on the user sign up page.  Users must enter the correct code corresponding with
Simple Captcha's generated image when registering. Usernames must also be unique.
E-mail verification has been pushed to Sprint 3.

## Implement Teammate Rating System (peer review view) {#peer-review}

This sprint covered both the database framework and actual implementation of the 
peer review rating system. Peer review was accomplished with both server-side 
processing and client-side manipulation of the DOM via a floating tactile dragable 
info-box interface.

## Design/Code Scoring/Pairing Algorithms and Procedures {#pair-alg}

Several scoring algorithms were considered for demonstration purposes for this
sprint and eventually a modified fibonachi peer review system was chosen as the 
most fair system. This was the only scoring algorithm implemented in this sprint.
A single-elimination pairing algorithm was chosen for similar reasons (as well 
as for simplicity in SVG generation).

## Implement game-type specific and tournament specific settings and preferences
   {#setting-and-pref}

The input for settings and preferences for creating tournaments are displayed 
dynamically in both the substance of the content and form in which it is displayed.

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

A new system was set-up so that matches are created from the trunk (final match) to
the most out matches, and teams are inserted into matches starting at the leaves and
and filling up the trunk. Any number of teams is now supported. A lot of log-based
math was used to write the rails-generated SVG, and a lot of arithmetic was done to
calculate the relative proportions.

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

## Not Applicable {#all-or-nothing}

Everything we implemented was implemented well, or else we didn't implement it.



# Not implemented

## Email Verification Option {#email-verify}

This was not implemented for lack of time. Luke probably would have been able to
implement it with his time constraints if he wasn't busy frequently assisting
other members with various problems. In the end, the email verification was also
simply a low priority.

## Project Leaguer Logo {#logo} 

The Project Leaguer Logo was discussed before the sprint started. We decided we
would follow up on any opportunities to explore creating a Leauger Logo, but this
simply did not happen. We greatly want one, but it's still just a low priority
extra feature.

## Define Specific Unit Tests for Security   {#security-test}

Because of heavy "dog-food" style testing during the development process and
fairly heavy rapid redesign, specific unit tests were not given a high priority
for this sprint. The interdependency of components for tournament logic provided
near-instant feedback when something was wrong.

# How to improve

1. We can better document our code with proper commentation and indentation. The
team has run into issues where we've become confused with our own code and wasted
time reviewing code.

2. Our commits slowed to a halt the week before spring break. In this upcoming 
sprint we plan to take a stronger initiative and take a running start rather than
a last lap dash.

3. We can more carefully push and merge. We ran into a couple issues where team
members broke each others work. These mistakes cost a lot of time to fix.

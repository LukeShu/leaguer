---
title: Design Document
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

Version 1.0 – 2014.02.10
Created 2014.02.09

# Purpose

The purpose of this document is to outlay the design, intent, and structure of
the Project Leaguer tournament organizing software.

Released under an open license, Project Leaguer leverages powerful web
technologies to provide everything needed to organize an online tournament.
Whether it's League of Legends, Chess, Poker, or more, Project Leaguer provides
tournament organizers, participants, and spectators with an online
interface to keep up with the score. Even better Project Leaguer offers scoring 
features and options which would be very difficult to implement with traditional 
tournament organizing practices such as peer review and team-independent 
individual scoring.

The software itself operates as a stand-alone background server application
accessible and configurable though its web interface which reveals to users a 
sleek web application which manages tournaments.
 
# Non-Functional Requirements

1.	Security: - Because Project Leaguer servers may store sensitive user information like name, email, statistics, user-name, profile, etc. it is an important non-functional requirement that such data is well secured from both accidental exposure and intentional tampering. Even so, the System may not be responsible for the theft of user information or even alterations made to the database from a source different from that of Leaguer.
2.	Backup: - The Leaguer system provides a user with a database of user information and is updated and stored, which is functional. In contrast, the non-functional requirement of leaguer is its ability to back up all the information of the user when the user chooses to suspend or delete record or even when the user happens to disconnect from the server.
3.	Platform Compatibility: - A non-functional requirement for the system is to be able to run on multiple platforms. Primarily a web based application, Leaguer may not be able to install into embedded gaming devices and special operation systems that do not run the interface that Leaguer was initially built on.


# Design Outlines

## Design Decisions and Components

Project Leaguer is written on the Ruby on Rails platform and will use
the “Model 2” (often mis-identified as “MVC”) design
pattern/architecture.  This architecture is comprised of three
interacting components: Controllers, Views, and Models.

![](DesignDocument-architecture-model2.pdf)\ 

Controllers
  : Requests received by the server are processed by a routing
    subroutine and directed to a controller responsible for handling
    them. Controllers accept these requests and manage any logic
    necessary to obtain the correct content for display, retrieving
    and updating information from the Model as needed.  It then
    creates a new request, places the content from the model in the
    request (if applicable), decides which view it will be passed to,
    and passes on the request.

Models
  : In Ruby on Rails, models are usually implemented as an interface
    to a table in the database and a Ruby file which queries this
    table and interacts with the other components.  For example, a
    "user" model would be connected to the "user" table and a file
    "user.rb" in the app/models directory would provide an interface
    to interact with the "user" controller.

Views
  : Views will primarily be dynamically generated HTML pages and will
    display the users desired content inside of the web browser. These
    may be implemented with inline Ruby scripts and tags within
    traditional HTML.

## Component Interaction

Controllers will be used to run all of the background work of Leaguer.  They will fetch the necessary data and will tell the view what to do.  We will be implementing seven controllers into Leaguer.  Those will be:

   i. PM & Alerts – This controller will be used for sending and receiving private messages to and from the host.  Players will be able to message the host in order to inform him/her of anything during the tournament.  This will also allow the host to post any notifications he or she desires that will be displayed for all to see.
  ii. Homepage – Used to handle the homepage.  This will be the first web page seen by any user of the application.
 iii. Login – This controller will be used when a user attempts to sign in to their profile on Leaguer.
  iv. Search – This controller will be used to search the web-base for on going tournaments, players and past tournaments.
   v. Tournament – Used for setting up a tournament.  This will be restricted to the host of the tournament.
  vi. User – The controller that will take each user to their own profile.
 vii. Match/Peer Review – used for gather game statistics and the separate player reviews.

Each of these controllers will fetch the data specified by its separate section.  The view will then be used to display all of this information, so Login will take the user to a login page, search will take the user to a search page and so on.

The Model will be the data section that will map all of the information to their proper locations in the data base.

# Design Issues
 
## Scoring Algorithm

In an effort to keep our system broad, one of our requirements is that Leaguer is adaptable to many competitions, not just League of Legends. How do we assure that the different scoring systems of different sports are represented in Leaguer?

Option 1: One of our interfaces could be “Scoring System” which will be implemented by many classes with common scoring systems. For example there would be a implementing class in which the highest score wins, and one in which the lowest score wins. This is likely to be the winning option, as there are not too many obscure scoring systems that we could not think of. 

Option 2: We could design an API in which the host writes a method to update the scoring. This is pretty complex, and while it would allow more customization, it is hard to imagine completing this task without first completing option 1.

## Offline Data Management

Leaguer manages players and games within tournaments, but it also stores statistics about the games and players themselves.  We need a system to store this information after the server-host shuts down the server.

Option 1: Perhaps the simplest and most intuitive option is to implement a database dump system. The server would dump the information into an SQL format.  All game and player data would be stored to the host and could be restored to a new server. The host would be responsible for preserving the data.  Additional security measures could be implemented to help protect data.  This option leaves the users with great control over the data.

Option 2: We could host Leaguer ourselves with our own server. All users would connect to it instead of to a user-hosted server.  Game and player information would be stored and maintained on Leaguer's server and the users would not need to manage data themselves, but instead we would have to host the service.

## Fetching Data from Games

Obtaining the statistics from the end of game or match is a vital step in Leaguer's function.  A quick and easy method for obtaining this information will ensure smooth usability.

Option 1: In the case of online multiplayer games, such as League of Legends, it may be possible to obtain the information directly from the game-hosted server or even websites that already do so.  In the case of League of Legends, lolking.net and lolnexus.com already grab statistics from the server automatically.  There are also some open source projects, such as data-hut on GitHub, that could be used to help extract and categorize the data itself. This option is complex, but also highly desirable for compatible games, as it ensures a fast and simple environment for our users.

Option 2: Users manually enter the data themselves. Different games would require different methods for the users to implement.  In the case of online games, users could take screenshot of a match's score screen (and then the statistics would be manually entered in), or a select pool of users could be responsible for recording the information and then entering it in.  This option is tedious and undesirable.

Option 3: Use Optical Character Recognition to obtain statistics from score screen screenshots. This option would require someone to take a screenshot in each match and submit it to Leaguer.  This would require more work than Option 1, but much less than Option 2.  An OCR plugin would have to be implemented for each game and thus support would be limited from game to game. Outside contributors could help widen the number of games with OCR support.

# Design Details
## Class Descriptions and Interactions

### MODELS

![](DesignDocument-models.pdf)\ 

ActiveRecord::Base (abstract)
  : The abstract model that all other models inherit from.

Server
  : Server model providing access to system settings such as Language, Time_Zone, Server_name, Owner_name, and Version.

Tournement
  : This model represents the structure of a tournement.  It will have several data sections to it including:  The match settings, the matches contained inside of the tournement, and the registered players that are participating in the tournement.

Match
  : A match will be a single set of data that contains all of the statistics of one game.

Team
  : This model will consist of a list of players for a tournement/game. The team creation process will either be pre-determined teams, or randomly assigned teams.  

User
  : This model represents all types of users; hosts, players, and
    spectators.  These roles are identified by a “role” attribute.
    TODO

### VIEWS

Asynchronous JavaScript may be used to load one view inside of
another.  From the core architecture, this does not matter, as the
same HTTP requests are made, though the user interaction is a little
cleaner.

layouts/application.html (abstract)
  : An abstract HTML file, that contains the basic page layout that
    all other views inherit.  If a user is not logged in, it contains
    a login form, and a registration button.  The form causes a POST
    to `LoginController#login()`, and the button causes a GET to
    `UserController#new()`.  If a user is logged in, it displays a
    logout button that causes a POST to `LoginController#logout()`.
    TODO: alerts, search

common/permission_denied.html
  : A generic page for when a user attempts to do something for which
    they don't have authorization.

common/invalid.html
  : A generic page for handling invalid requests (such as logging out
    when not logged in).

main/homepage.html
  : This page has 3 basic options. Visually simple – two large buttons
    on a white screen, and a search bar above them. The search bar
    will cause a POST request to the search controller. Log in (which
    will cause a POST to the login controller) and “Go to Tournament”
    in which you enter a tournament title. This interacts with the
    Homepage Controller.

main/edit.html
  : This page is a form for editing the server-wide configuration,
    such as the language or the graphical theme.

search/results.html
  : Shows the results of a search.  Each item is clickable and
    triggers a GET request to the relevent controller method.

messages/new_alert.html
  : TODO

messages/private.html
  : TODO

tournaments/index.html
  : TODO: list of tournaments

tournaments/show.html
  : Shows the information for a single tournament.  If the user is
    authorized, it also shows an “edit” button that triggers a the
    browser to GET `TournamentsController#edit()`.  This is a
    tree-like display of matches, where each match consists of a pair
    of teams. All users can click on a match to go to that match’s
    page.  Host can see a gear on top left corner that represents
    tournament settings, it will GET `TournamentsController#edit()`.
    There will be an “end” button that will redirect to back to the
    homepage after POSTing to `TournamentsController#end()`.

tournaments/new.html
  : A form for creating a new tournament.  The form is POSTed to
    `TournamentsController#create()`.

tournaments/edit.html
  : A form for editing an existing tournament.  The form is POSTed to
    `TournamentsController#update()`.

matches/show.html
  : Shows an individual match; q display of both teams. Each team's
    players are clickable which causes a GET for the player's profile
    HTML (`UsersController#show()`).  A link above both teams will GET
    the tournament the match belongs to
    (`TournamentsController#show()`).  This will POST its actions to
    the Match controller. TODO: What will POSTing do?

matches/edit.html
  : TODO: form to adit a match

teams/index.html
  : TODO: show list of teams

teams/show.html
  : TODO: show individual team

teams/new.html
  : MAYBE TODO: form to create a new team

teams/edit.html
  : TODO: form to edit a team

users/index.html
  : TODO: list of users

users/new.html
  : One for repeating the password, and one for email. This POST to
    the Login controller. TODO: complete sentences

users/show.html
  : A page with the user's information. One can view the player's
    reviews. If the user is viewing his/her own profile, they can edit
    it causing a POST to the userProfile controller. TODO: fix

users/edit.html
  : TODO


### CONTROLLERS

Any time "assuming the user has permission" it is mentioned, if the
user doesn't have permission, it renders the
`common/permission_denied` view.  This also means that the method
interacts with a `User` model to evaluate the permissions.

ApplicationController (abstract)
  : The base controller class that all other controllers inherit from.

MainController
  : This is the main controller. It has the following methods:

    - `show_homepage()` Responds to GET requests by rendering the
      `main/homepage` view.
    - `edit_settings()` Responds to GET requests by (if the user is
      authenticated and is a host) rendering the `main/edit` view that
      presents the user with a form to edit the `Server` model's
      settings; assuming the user has permission.
    - `update_settings()` Responds to POST requests by updating the
      `Server` model configuration with the POSTed settings.  It then
      renders the `main/edit` view with the updated settings.  This
      assumes the user has the permissions.

LoginController
  : This controller handles session management.  It contains two
    methods:

    - `login()` Responds to POST requests by seting a session token
      identifying the user.  If the credentials are correct, it sends
      a redirect that directs the browser to the page it would
      otherwise be on.  If the credentials are not correct, it renders
      the `common/permission_denied` view.  This queries the `User`
      model to validate the username and password.
    - `logout()` Responds to POST requests by clearing the session
      token, logging the user out, then redirects to the home page
      (`MainController#show_homepage()`).  If the was not logged in,
      it renders the `common/invalid` view.

SearchController
  : TODO

    - `show_results()` TODO: RESPONDS TO POST

MessagesController
  : TODO

    - `new_alert()` TODO: GET
    - `post_alert()` TODO: POST
    - `show_private()` TODO: GET
    - `post_private()` TODO: POST

TournamentsController
  : This controller will have methods:

    The following methods respond to GET requests by rendering the
    `tournaments/*` view with the same name:

    - `index()`
    - `show()`
    - `new()` (assuming the user has permission)
    - `edit()` (assuming the user has permission)

    The following methods respond to POST requests, assuming the user
    has permission:

    - `create()` Creates a new `Tournament` with the POSTed data.
      Then renders the `tournaments/show` view.
    - `update()` Updates the specified `Tournament` with the POSTed
      data.  Then renders the `tournaments/edit` view.
    - `end()` Ends the specified `Tournament`.  Then redirects to
      `MainController#show_hompage()`.

    All of these methods will interact with the `Tournament` model,
    and all of its fields including users matches and
    TournamentSettings.

MatchesController
  : TODO

    - `show()` TODO: GET
    - `edit()` TODO: GET
    - `update()` TODO: POST

TeamsController
  : TODO

    - `index()` TODO: GET
    - `show()` TODO: GET
    - `new()` MAYBE TODO: GET
    - `create()` MAYBE TODO: POST
    - `edit()` TODO: GET
    - `update()` TODO: POST

UsersController
  : TODO

    - `index()` TODO: GET
    - `new()` TODO: GET
    - `create()` TODO: POST
    - `show()` TODO: GET
    - `edit()` TODO: GET
    - `update()` TODO: POST
    - `delete()` TODO: POST

## UML Diagram of Classes

TODO – I’m working on this – see images.pptx ~ Tomer

So am I: ~ Luke

![](DesignDocument-classes.pdf)\ 

---
title: "Project Leaguer: Design Document"
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

Version 1.0 – 2014.02.10

# Purpose

The purpose of this document is to outlay the design, intent, and structure of
the Project Leaguer tournament organizing software.

Released under an open license, Project Leaguer leverages powerful web
technologies to provide everything needed to organize an online
tournament.  While it is designed with “League of Legends” in mind, it
should provide an online tournament interface that is easy to use for
tournament organizers, participants, and spectators for all kinds of
games, such as Chess, Poker, and more.  Even better, Project Leaguer
offers scoring features and options, such as peer review and
team-independent individual scoring, which would be very difficult to
implement with traditional tournament organizing practices.

The software itself operates as a stand-alone background server application
accessible and configurable though its web interface which reveals to users a 
sleek web application which manages tournaments.
 
# Non-Functional Requirements

Security
  : Because Project Leaguer servers may store sensitive user
    information like name, email, statistics, user-name, profile,
    etc. it is an important non-functional requirement that such data
    is well secured from both accidental exposure and intentional
    tampering.  Even so, the System may not be responsible for the
    theft of user information or even alterations made to the database
    from a source different from that of Leaguer.

Platform Compatibility
  : A non-functional requirement for the system is to be able to run
    on multiple platforms.  Primarily a web based application, Leaguer
    may not be able to install into embedded gaming devices and
    special operation systems that do not run the interface that
    Leaguer was initially built on.

Response Time
  : Even though the "Model 2" architecture tends to scale well for
    medium/large applications and data sets, it is still important to
    keep the response time of the system in mind.  Using efficient data
    structures, short time complexity algorithms, and minimizing
    network overhead whenever possible will help to keep the response
    time of the system reasonable even for large data sets or complex
    statistics or scoring schemes.


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

Controllers will be used to run all of the background work of Leaguer.  They will fetch the necessary data and will tell the view what to do.  We will be implementing eight controllers into Leaguer.  Those will be:

   i. PM & Alerts – This controller will be used for sending and receiving private messages to and from the host.  Players will be able to message the host in order to inform him/her of anything during the tournament.  This will also allow the host to post any notifications he or she desires that will be displayed for all to see.
  ii. Settings & Homepage – Used to handle the homepage.  This will be the first web page seen by any user of the application.
 iii. Login – This controller will be used when a user attempts to sign in to their profile on Leaguer.
  iv. Search – This controller will be used to search the web-base for on going tournaments, players and past tournaments.
   v. Tournament – Used for setting up a tournament.  This will be restricted to the host of the tournament.
  vi. User – The controller that will take each user to their own profile.
 vii. Match/Peer Review – used for gather game statistics and the separate player reviews.
viii. Teams - This controller will be used to handle the separate teams.  It will contain: a list of the team's members and will be used to handle team roster modifications. 

Each of these controllers will fetch the data specified by its separate section.  The view will then be used to display all of this information, so Login will take the user to a login page, search will take the user to a search page and so on.

The Model will be the data section that will map all of the information to their proper locations in the data base.

# Design Issues
 
## Scoring Algorithm

In an effort to keep our system broad, one of our requirements is that Leaguer is adaptable to many competitions, not just League of Legends. How do we assure that the different scoring systems of different sports are represented in Leaguer?

Option 1
  : One of our interfaces could be “Scoring System” which will be
    implemented by many classes with common scoring systems. For
    example there would be a implementing class in which the highest
    score wins, and one in which the lowest score wins. This is likely
    to be the winning option, as there are not too many obscure
    scoring systems that we could not think of.

Option 2
  : We could design an API in which the host writes a method to update
    the scoring. This is pretty complex, and while it would allow more
    customization, it is hard to imagine completing this task without
    first completing option 1.

## Offline Data Management

Leaguer manages players and games within tournaments, but it also stores statistics about the games and players themselves.  We need a system to store this information after the server-host shuts down the server.

Option 1
  : Perhaps the simplest and most intuitive option is to implement a
    database dump system. The server would dump the information into
    an SQL format.  All game and player data would be stored to the
    host and could be restored to a new server. The host would be
    responsible for preserving the data.  Additional security measures
    could be implemented to help protect data.  This option leaves the
    users with great control over the data.

Option 2
  : We could host Leaguer ourselves with our own server. All users
    would connect to it instead of to a user-hosted server.  Game and
    player information would be stored and maintained on Leaguer's
    server and the users would not need to manage data themselves, but
    instead we would have to host the service.

## Fetching Data from Games

Obtaining the statistics from the end of game or match is a vital step in Leaguer's function.  A quick and easy method for obtaining this information will ensure smooth usability.

Option 1
  : In the case of online multiplayer games, such as League of
    Legends, it may be possible to obtain the information directly
    from the game-hosted server or even websites that already do so.
    In the case of League of Legends, `lolking.net` and `lolnexus.com`
    already grab statistics from the server automatically.  There are
    also some open source projects, such as data-hut on GitHub, that
    could be used to help extract and categorize the data itself. This
    option is complex, but also highly desirable for compatible games,
    as it ensures a fast and simple environment for our users.

Option 2
  : Users manually enter the data themselves. Different games would
    require different methods for the users to implement.  In the case
    of online games, users could take screenshot of a match's score
    screen (and then the statistics would be manually entered in), or
    a select pool of users could be responsible for recording the
    information and then entering it in.  This option is tedious and
    undesirable.

Option 3
  : Use Optical Character Recognition to obtain statistics from score
    screen screenshots. This option would require someone to take a
    screenshot in each match and submit it to Leaguer.  This would
    require more work than Option 1, but much less than Option 2.  An
    OCR plugin would have to be implemented for each game and thus
    support would be limited from game to game. Outside contributors
    could help widen the number of games with OCR support.

# Design Details
## Class Descriptions and Interactions

### MODELS

![](DesignDocument-models.pdf)\ 

ActiveRecord::Base (abstract)
  : The abstract model that all other models inherit from.

Server
  : Server model providing access to system settings such as Language, Time_Zone, Server_name, Owner_name, and Version. This class is edited and read by the MainController.

Tournament
  : This model represents the structure of a tournament.  It will have several data sections to it including:  The match settings, the matches contained inside of the tournament, a unique id for the tournament, and the registered players that are participating in the tournament. This class interacts with a multitude of other model classes (see UML) and all four tournament controllers.

Match
  : A match will be a single set of data that contains all of the statistics of one game.  This includes: players personal scores, team members, scores for each team, game time, the tournament that match took place in, and the date. This model interacts with the match controller, and is both a part of and has a many to one relationship with a tournament object.

Team
  : This model will consist of a list of players for a tournament. The team creation process is chosen by the host of the tournament and team setup will either be pre-determined teams or randomly assigned teams. This model interacts with the tournament model class.

User
  : This model represents all types of users; hosts, players, and
    spectators.  These roles are identified by a “role” attribute. The user is an object that is often referenced by other classes, including tournament, match, and team.

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
    It may contain an alert box of recent alerts submitted by a
    tournament host.  It contains a search form that is POSTed to
    `SearchController#show_results`.  If the user is authorized to
    publish alerts, it also contains a button that causes the browser
    to GET `MessagesController#new_alert()`.

common/permission_denied.html
  : A generic page for when a user attempts to do something for which
    they don't have authorization.

common/invalid.html
  : A generic page for handling invalid requests (such as logging out
    when not logged in).

main/homepage.html
  : This page is visually simple.  In addition to the basic functions
    of `layouts/application`, this page has a “Go to Tournament” text
    area, in which you enter a tournament title, and will take you to
    the relevant tournament page.

main/edit.html
  : This page is a form for editing the server-wide configuration,
    such as the language or the graphical theme.  The form is
    submitted to `MainController#update()`.

search/results.html
  : Shows the results of a search.  Each item is clickable and
    triggers a GET request to the relevant controller method.

messages/new_alert.html
  : This is a form for a host to submit a new system-wide alert.  The
    form is POSTed to `MessagesController#post_alert()`.

messages/private.html
  : This page is used to handle user private messaging.  It both
    displays private messages, and contains a form for sending a new
    private message.  New messages are POSTed to
    `MessageController#post_private()`

tournaments/index.html
  : Shows a list of tournaments.  Clicking on any of them causes the
    browser GET that tournament via `TournamentController#show()`.  If
    the user is authorized, it also contains a button that causes the
    browser to GET `TournamentsController#new()`.

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

matches/index.html
  : Shows a list of matches.  Clicking on any of them causes the
    browser to GET that match via `MatchesController#show()`.

matches/show.html
  : Shows an individual match; a display of both teams. Each team's
    players are clickable which causes a GET for the player's profile
    HTML (`UsersController#show()`).  A link above both teams will GET
    the tournament the match belongs to
    (`TournamentsController#show()`).  If the user is authorized, it
    also has a button to edit the match by GETting
    `MatchesController#edit()`.

matches/edit.html
  : Shows a form to edit a match.  The form is POSTed to
    `MatchesController#update()`.  After a match has been completed,
    this included peer-review input by the players.

teams/index.html
  : Shows a list of teams.  Clicking any of them causers the browser
    to GET that team via `TeamsController#show()`.

teams/show.html
  : Show an individual team, including statistics, and links to
    individual members (GET `UsersController#show()`).  If the user is
    authorized, it also has a button do edit the team by GETting
    `TeamsController#edit()`.

teams/edit.html
  : A form to manually edit a team, and its members.  The form
    contents are POSTed to `TeamsController#update()`.

users/index.html
  : Show a list of users.  Clicking any of them causers the browser
    to GET that user via `UsersController#show()`.

users/new.html
  : Shows a form for creating a new user.  It includes fields for
    username, email, password, and other information.  The form is
    POSTed to `UsersController#create()`;

users/show.html
  : A page with the user's information. One can view the player's
    reviews.  If the user is authorized, it also has a button do edit
    the user by GETting `UsersController#edit()`.

users/edit.html
  : A form to edit a user; including meta-data and tournament
    registration.  The form is POSTed to `UsersController#update()`.

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

    - `login()` Responds to POST requests by setting a session token
      identifying the user.  If the credentials are correct, it sends
      a redirect that directs the browser to the page it would
      otherwise be on.  If the credentials are not correct, it renders
      the `common/permission_denied` view.  This queries the `User`
      model to validate the username and password.
    - `logout()` Responds to POST requests by clearing the session
      token, logging the user out, then redirects to the home page
      (`MainController#show_homepage()`).  If the user was not logged in,
      it renders the `common/invalid` view.

SearchController
  : This controller handles user search terms. It has one method:

    - `show_results()` Responds to POST by accessing whichever model(s)
      contains the information requested and renders the `search/results` view.

MessagesController
  : This controller handles inter-user messages.  It has a couple
    methods that respond to GET requests:

    - `new_alert()` Renders the `messages/new_alert` template,
      assuming the user has permission.
    - `show_private()` Renders the `messages/private template,
      assuming the user has permission.

    It also has methods that respond to POST requests:

    - `post_alert()` Publishes a new system-wide alert, assuming the
      user has permission.  It then redirects the browser to whichever
      page it would otherwise be on.
    - `post_private()` Sends a new private message, assuming the user
      has permission.

TournamentsController
  : The following methods respond to GET requests by rendering the
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
  : The following methods respond to GET requests by rendering the
    `matches/*` view with the same name:

    - `index()`
    - `show()`
    - `edit()`

    The following methods respond to POST requests, assuming the user
    has permission:

    - `update()` Updates the specified `Match` with the POSTed data.

TeamsController
  : The following methods respond to GET requests by rendering the
    `teams/*` view with the same name:

    - `index()`
    - `show()`
    - `edit()`

    The following methods respond to POST requests, assuming the user
    has permission:

    - `update()` Update the specified `Team` with the POSTed data.

UsersController
  : The following methods respond to GET requests by rendering the
    `users/*` view with the same name:

    - `index()`
    - `show()`
    - `new()`
    - `edit()`

    The following methods respond to POST requests, assuming the user
    has permission:

    - `create()` Creates a new `User` with the POSTed data.
    - `update()` Update the specified `User` with the POSTed data.
    - `delete()` Deletes the specified `User` account.

## UML Diagram of Classes

This diagram does not show all models inheriting from
`ActiveRecord::Base`, all views inheriting from `layouts/application`,
or all controllers inheriting from `ApplicationController`.  It
does not show interactions with the `User` model that solely check
authorization to perform an action.  It does not show controller
methods calling the error views.  It shows transitions from a view to
a controller *only* when that is the *primary* purpose of the view; many
workflows can be interrupted at any time.  Arrows between models and
controllers indicate which direction data is flowing.  Any data
flowing from a model to the method of a controller is implicitly
passed to the view that method renders.

![](DesignDocument-classes.pdf)\ 

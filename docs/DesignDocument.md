---
title: Design Document
author: [ Nathaniel Foy, Guntas Grewal, Tomer Kimia, Andrew Murrell, Luke Shumaker, Davis Webb ]
---

Version 1.0 – 2014.02.10
Created 2014.02.09

# Purpose

The purpose of this document is to outlay the desgin, intent, and structure of
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
 
#Non-Functional Requirements

TODO Guntas. Email dunsmore and marco about this, then fill it out. 

# Design Outlines

## Design Decisions and Components

Project Leaguer is written on the Ruby on Rails platform and will use the Model 2 (MVC) design pattern/architecture. This architecture is comprised of three interacting components: Controllers, Views, and Models.

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

<<<<<<< HEAD
**4:  Design Issues**
 
**4.1 Scoring Algorithm**
In an effort to keep our system broad, one of our requirements is that Leaguer is adaptable to many competitions, not just League of Legends. How do we assure that the different scoring systems of different sports are represented in Leaguer?

Option 1: One of our interfaces could be “Scoring System” which will be implemented by many classes with common scoring systems. For example there would be a implementing class in which the highest score wins, and one in which the lowest score wins. This is likely to be the winning option, as there are not too many obscure scoring systems that we could not think of. 

Option 2: We could design an API in which the host writes a method to update the scoring. This is pretty complex, and while it would allow more customization, it is hard to imagine completing this task without first completing option 1.

**4.2 Offline Data Management**
Leaguer manages players and games within tournaments, but it also stores statistics about the games and players themselves.  We need a system to store this information after the server-host shuts down the server.

Option 1: Perhaps the simplest and most intuitive option is to implement a database dump system. The server would dump the information into an SQL format.  All game and player data would be stored to the host and could be restored to a new server. The host would be responsible for preserving the data.  Additional security measures could be implemented to help protect data.  This option leaves the users with great control over the data.

Option 2: We could host Leaguer ourselves with our own server. All users would connect to it instead of to a user-hosted server.  Game and player information would be stored and maintained on Leaguer's server and the users would not need to manage data themselves, but instead we would have to host the service.

**4.3 Fetching Data from Games**
Obtaining the statistics from the end of game or match is a vital step in Leaguer's function.  A quick and easy method for obtaining this information will ensure smooth usability.

Option 1: In the case of online multiplayer games, such as League of Legends, it may be possible to obtain the information directly from the game-hosted server or even websites that already do so.  In the case of League of Legends, lolking.net and lolnexus.com already grab statistics from the server automatically.  There are also some open source projects, such as data-hut on github, that could be used to help extract and categorize the data itself. This option is complex, but also highly desirable for compatible games, as it ensures a fast and simple enviornment for our users.

Option 2: Uers manually enter the data themselves. Different games would require different methods for the users to implement.  In the case of online games, users could take screenshot of a match's score screen (and then the statistics would be manually entered in), or a select pool of users could be responsible for recording the information and then entering it in.  This option is tedious and undesirable.

Option 3: Use Optical Character Recognition to obtain statistics from score screen screenshots. This option would require someone to take a screenshot in each match and submit it to Leaguer.  This would require more work than Option 1, but much less than Option 2.  An OCR plugin would have to be implemented for each game and thus support would be limited from game to game. Outside contributors could help widen the number of games with OCR support.

5 Design Details
5.1 Class Descriptions and Interactions

VIEWS
Webpage: An abstract HTML file, all entries below are webpages (we represent them as subclasses of the abstract “Webpage” class. All webpages will send HTTP requests to the server. Most of the visual effects and update the display with Javascript methods. Each page will have a login dialogue which will POST to the login controller or the logged in user’s page. 
=======
# Design Issues
 
## Scoring Algorithm
>>>>>>> 547268b749cfcb273e04fc78c2ad2fc693238be6

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

TODO – Nathniel write this

## Fetching Data from Games

TODO – Nathaniel write this.

# Design Details
## Class Descriptions and Interactions

### MODELS

ActiveRecord::Base (abstract)
  : The abstract model that all other models inherit from.

User
  : This model represents all types of users; hosts, players, and
    spectators.  These roles are identified by a “role” attribute.

### VIEWS

layouts/application.html (abstract)
  : An abstract HTML file, all entries below are webpages (we
    represent them as subclasses of the abstract “Webpage” class. All
    webpages will send HTTP requests to the server. Most of the visual
    effects and update the display with Javascript methods. Each page
    will have a login dialogue which will POST to the login controller
    or the logged in user’s page.

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

login/form.html
  : Page with form entries for username, password. If user clicks “new
    user” more forms entries will appear. One for repeating the
    password, and one for email. This POST to the Login controller.

tournaments/new.html
  : A form that interacts with users who are either hosts or becoming
    hosts. This interacts with tournament controller.

tournaments/index.html
  : A tree-like display of matches, where each match consists of a
    pair of teams. All users can click on a match to go to that
    match’s page.  Host can see a gear on top left corner that
    represents tournament settings, it will GET the edit Tournament
    view. There will be an end button that will redirect to back to
    the homepage after posting to the tournament controller. The
    tournament will POST to the tournament controller.

tournaments/edit.html
  : This view is a list of settings. Some are form entries, and some
    are checkboxes. More settings will be added later in
    develpment. This view interacts with the tournament controller.

matches/show.html
  : A display of both teams. Each team's players are clickable which
    causes a GET for the player's profile HTML. A link above both
    teams will GET the tournament the match belongs to. This will POST
    its actions to the Match controller.

search/form.html
  : A page with a searchbar and a list of searchable tournaments that
    match the search query. The searchbar causes a POST to the search
    controller. Each entry is clickable and causes a GET to the
    enrry's tournament.
search/results.html
  : A page that shows search results.

users/show.html
  : A page with the user's information. One can view the player's
    reviews. If the user is viewing his/her own profile, they can edit
    it causing a POST to the userProfile controller.

### CONTROLLERS

ApplicationController (abstract)
  : The base controller class that all other controllers inherit from.

MainController
  : This is the main controller. It has the following methods:

    - `show_homepage()` Responds to GET requests by rendering the
      `main/homepage` view.
    - `edit_settings()` Responds to GET requests by (if the user is
      authenticated and is a host) rendereing the `main/edit` view
      that presents the user with a form to edit the server settings.
      If the user is not authenticated, it renders the
      `common/permission_denied` view.  This involves interacting with
      the `User` model to determine whether the user is authorized to
      see this.
  - `update_settings()` Responds to POST requests by updating the
      server configuration with the POSTed settings.  It then either
      renders the `common/permission_denied` view, or the `main/edit`
      view with the updated settings.  This involves interacting with
      the `User` model to determine whether the user is authorized to
      do this.

LoginController
  : This has doLogin() and doLogout(). Both have access to the HTTP
    requrest. It will interact with the Users model to validate
    passwords and usernames.

TournamentController
  : This controller will have methods: newTorunament(),
    getTournament(), editTournament(), and endTournament(). All of
    these methods will interact with the Tournament model, and all of
    its fields including users matches and TournamentSettings. And all
    will interact with their tournament view, for example,
    newTournament() will render newTorunament.

Server
  : Rails’ Server class handles all HTTP events. Our Server class is
    the class that is the main program. It instantiates other classes,
    manages requests from Views, and runs static methods.

User
  : A class that represents someone using the Views (HTML, javascript)
    the user is in competitions and


## UML Diagram of Classes

TODO – I’m working on this – see images.pptx ~ Tomer

So am I: ~ Luke

![](DesignDocument.png)\

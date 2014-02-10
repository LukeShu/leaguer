Design Document  
Version 1.0 – 2014.02.09 
Created 2014.02.09 
 
Leaguer
Nathaniel Foy
Guntas Grewal
Tomer Kimia
Andrew Murell
Luke Shumaker
Davis Webb
 
1. Contents
1Purpose	3
2Non-Functional Requirements	3
3Design Outlines	3
3.1Design Decisions and Components	3
3.2Component Interaction	3
4Design Issues	3
4.1Scoring Algorithm	3
4.2Offline Data Management	3
4.3Fetching Data from Games	3
5Design Details	4
5.1Class Descriptions and Interactions	4
5.2UML Diagram of Classes	4

 
1 Purpose
This document describes all components of the Leaguer Tournament management system. Leaguer is a software to be installed and run on a server. TODO. ANDREW COMPLETE THIS.
 
2 Non-Functional Requirements
TODO Guntas. Email dunsmore and marco about this, then fill it out. 

3 Design Outlines 

3.1 Design Decisions and Components
Our system will on the Model 2 design pattern/architecture. TODO: Davis – add the purpose of EACH component as a list.
Controllers – The controllers will control any logic necessary to obtain the correct content for display.  It then places the content in the request and decides which view it will be passed to.

Models – We will be using a Ruby on Rails model.  The Ruby on Rails framework maps to a table in the database and a Ruby file.  So a User will usually be difined as user.rb in the app/models directory and this will be linked to the table users in the database.

Views – Views will be the HTML pages for Leaguer, and will display the users desired content inside of the web browser. 

Component Interaction

     Controllers will be used to run all of the background work of Leaguer.  They will fetch the necessary data and will tell the view what to do.  We will be implementing seven controllers into Leaguer.  Those will be:
	  I.   PM & Alerts – This controller will be used for sending and receiving private messages to and from the host.  Players will be able to message the host in order to inform him/her of anything during the tournament.  This will also allow the host to post any notifications he or she desires that will be displayed for all to see.
     II.  Homepage – Used to handle the homepage.  This will be the first web page seen by any user of the application.
     III.  Login – This controller will be used when a user attempts to sign in to their profile on Leaguer.
     IV.  Search – This controller will be used to search the web-base for on going tournaments, players and past tournaments.
	 V.  Tournament – Used for setting up a tournament.  This will be restricted to the host of the tournament.
     VI.  User – The controller that will take each user to their own profile.
     VII.  Match/Peer Review – used for gather game statistics and the separate player reviews.

Each of these controllers will fetch the data specified by its separate section.  The view will then be used to display all of this information, so Login will take the user to a login page, search will take the user to a search page and so on.

The Model will be the data section that will map all of the information to their proper locations in the data base

Design Issues
 
Scoring Algorithm
In an effort to keep our system broad, one of our requirements is that Leaguer is adaptable to many competitions, not just League of Legends. How do we assure that the different scoring systems of different sports are represented in Leaguer?
Option 1: One of our interfaces could be “Scoring System” which will be implemented by many classes with common scoring systems. For example there would be a implementing class in which the highest score wins, and one in which the lowest score wins. This is likely to be the winning option, as there are not too many obscure scoring systems that we could not think of. 

Option 2: We could design an API in which the host writes a method to update the scoring. This is pretty complex, and while it would allow more customization, it is hard to imagine completing this task without first completing option 1.

4.2 Offline Data Management
TODO – Nathniel write this
4.3 Fetching Data from Games
TODO – Nathaniel write this.

5 Design Details
5.1 Class Descriptions and Interactions

VIEWS
Webpage: An abstract HTML file, all entries below are webpages (we represent them as subclasses of the abstract “Webpage” class. All webpages will send HTTP requests to the server. Most of the visual effects and update the display with Javascript methods. Each page will have a link to either the login or the logged in user’s page. 
Homepage: This page has 3 basic options. Visually simple – two large buttons on a white screen, and a search bar above them. The search bar will allow you to search upcoming or current searchable tournaments. Log in (which will take you to the login page) and “Go to Tournament” in which you enter a tournament title. This interacts with the Homepage Controller.
Login: Page with form entries for username, password. If user clicks “new user” more forms entries will appear. One for repeating the password, and one for email. This interacts with the Login controller.
Tournament: A tree-like display of pairs of matches, where each match consists of a pair of teams. All users can click on a match to go to that match’s page.  Host can see a gear on top left corner that represents tournament settings. This will open up more options for the host to change. This interacts with the tournament controller.
Match: A display of both teams.

Server: Rails’ Server class handles all HTTP events. Our Server class is the class that is the main program. It instantiates other classes, manages requests from Views, and runs static methods.
User: A class that represents someone using the Views (HTML, javascript) the user is in competitions and 
		

5.2 UML Diagram of Classes
TODO – I’m working on this – see images.pptx

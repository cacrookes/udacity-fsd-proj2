Swiss-style Tournament Database and Library
===========================================

About
-----

This project can be used to create a database for storing tournament results.
A library, tournament.py, is included to interact with the database. It provides
functionality for running a swiss-style tournament. The library can 

How to run
----------

Set up datbase
---------------
1. Create a postgres database named 'tournament'.
2. Import the tables and view specified in 'tournament.sql'
	i) This can be accomplished by running '\i tournament.sql' from the psql command line.
Congrats, you now have a database ready to use!

Running a tournament
--------------------
1. Register players for a tournament using 'registerPlayer(name, tournament, player_id)'
	a. only 'name' is required.
	b. if 'tournament' is left blank, or set to 0, the player will be registerd for the next
	   tournament.
  c. specifiy a 'player_id' to register an existing player for a new tournament. If left blank
	   or set to 0, a brand new player will be created. Note, there can be multiple players with
		 the same name.
2. Run 'swissPairings()' to generate match-ups for the first/next round
3. For each match, record the results using 'reportMatch(winner, loser, draw, tournament)'
	a. 'winner' and 'loser' take player_ids for values. In the event of a draw, it doesn't matter
	   which player is listed as winner or loser. Both players will have a draw recorded as their 
		 result.
	b. 'draw' is optional. It is set to 'False' by default.
	c. 'tournament' is optional. If left blank or set to 0, the match will be added to the most recent
	   tournament.
4. Repeat steps 2 and 3 until all rounds of the tournament have been played.
5. Run 'playerStandings(tournament)' to get the standings for the tournament. Returns a list of tuples
   containing (id, name, wins, matches)
  a. 'tournament' is optional. If left blank or set to 0, the standings of the latest tournament
	   will be returned.
	b. Results will be sorted based on the number of points each player has. Points are calculated as
	   2 points per win, 1 point per draw. However, due to the expected output from the supplied test
		 cases, the output only indicates the number of wins each player has. Points and number of draws
		 are not included.

Database Management
-------------------
A few functions are provided to help manage the database

deleteMatches(tournament)
	-deletes all matches from the tournament_matches table for the specified tournament
	-'tournament' is optional. If left blank or set to 0, matches for the last tournament will be deleted.
	-set 'tournament' to '-1' in order to delete match data for all tournaments

deletePlayers(tournament)
	-Remove all the player records from the database for the specified tournament. If a player is no
	 longer registered for any tournaments, the player will also be deleted from master player table.
	-'tournament' is optional. If left blank or set to 0, player records for the latest tournament will be
	 deleted.
	-set 'tournament' to '-1' in order to delete all player data for all tournaments.

countPlayers(tournament)
	-Returns the number of players currently registered in the specified tournament.
	-tournament' is optional. If left blank or set to 0, the number of players registered for the lastest
	 tournament will be returned.
	-set 'tournament' to '-1' in order to get all players registered in every tournament. Each player is
	 only counted once, even if they are registered for multiple tournaments.

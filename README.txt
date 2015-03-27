Swiss-style Tournament Database and Library
===========================================

About
-----

This project can be used to create a database for storing tournament results.
A library, tournament.py, is included to interact with the database. It provides
functionality for running a swiss-style tournament.

How to run
----------

Set up datbase
---------------
**WARNING**, if you already have a database named 'tournament', running the following
commands will remove your existing tournament database and create a new database named
tournament.
The 'tournament.sql' script can be used to setup a Postgres database. To setup using the
PostgreSQL interactive terminal:
1. From your terminal, navigate to the directory containing the 'tournament.sql' file.
2. Start the PostgreSQL interactive terminal by running 'psql'.
3. You should now be in the psql terminal. Run the command '\i tournament.sql'.
  * If there already is a database named 'tournament', it will be dropped.
  * A new database named 'tournament' will be created.
  * The new database will be populated with the tables: players, tournament_matches,
    tournament_roster; and the view: player_rankings.

Congrats, you now have a database ready to use!

Testing the database
--------------------
This package includes a file 'tournament_test.py' which can be used to test the database is
set-up properly. In order to run:
1. From your terminal, navigate to the directory containing the 'tournament_test.py' file.
   This file is in the same location as the 'tournament.sql' file.
2. Run the file from the terminal using the command 'python tournament_test.py'



Running a tournament
--------------------
1. Register players for a tournament using 'registerPlayer(name, tournament, player_id)'
	a. only 'name' is required.
	b. if 'tournament' is left blank, or set to 0, the player will be registerd for the next
	   tournament.
  c. specify a 'player_id' to register an existing player for a new tournament. If left blank
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
	-tournament' is optional. If left blank or set to 0, the number of players registered for the latest
	 tournament will be returned.
	-set 'tournament' to '-1' in order to get all players registered in every tournament. Each player is
	 only counted once, even if they are registered for multiple tournaments.

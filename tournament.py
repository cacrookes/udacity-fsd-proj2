#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")

def execute_query(sql_query):
    """Executes query

    Args:
      sql_queries: query to execute
    """

    conn = connect()
    cur = conn.cursor()
    cur.execute(sql_query)
    cur.close()
    conn.commit()
    conn.close()

def deleteMatches(tournament=0):
    """Remove all the match records from the database for the specified tournament.

    Args:
      tournament: (optional) specifies which tournament to delete.
                 Specify 0 to delete the most recent tournament.
                 Specify -1 to delete all tournaments.
                 Defaults to 0 if not specified.
    """
    sql_query = "" # will specify query to execute
    if tournament == 0:
        sql_query = "DELETE FROM tournament_roster WHERE tournament_id = MAX(tournament_id);"
        sql_query = "DELETE FROM tournament_matches WHERE tournament_id = MAX(tournament_id);"
    elif tournament = -1:
        sql_query = "DELETE FROM tournament_roster; DELETE FROM tournament_matches;"
    else:
        sql_query = "DELETE FROM tournament_roster WHERE tournament_id = %i;", tournament
        sql_query = "DELETE FROM tournament_matches WHERE tournament_id = %i;", tournament

    execute_query(sql_query)



def deletePlayers(tournament=0):
    """Remove all the player records from the database for the specified tournament.

    Args:
      tournament: (optional) specifies which tournament to delete players from.
                 Specify 0 to delete player data from the most recent tournament.
                 Specify -1 to delete all player data in all tournaments.
                 Defaults to 0 if not specified.
    """

def countPlayers(tournament=0):
    """Returns the number of players currently registered in the specified tournament.

    Args:
      tournament: (optional) specifies which tournament to count the players from.
                 Specify 0 to count the players in the most recent tournament.
                 Specify -1 to count all players in all tournaments. Each player is
                 only counted once, regardless of number of tournaments entered.
                 Defaults to 0 if not specified.
    """


def registerPlayer(name, tournament=0, player_id=0):
    """Adds a player to the tournament database and assigns player to the specified
       tournament.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Returns:
      An integer storing the player's id. This can be used for registering the player
      in future tournaments.

    Args:
      name: the player's full name (need not be unique).
      tournament: (optional) specifies which tournament to register the player for.
                 Specify 0 to count the players in the most recent tournament.
                 Specify -1 to count all players in all tournaments. Each player is
                 only counted once, regardless of number of tournaments entered.
                 Defaults to 0 if not specified.
      player_id: (optional) if the player has registered for a previous tournament,
                 they can register for a new tournament with their player_id. If a
                 player_id is specified, the player is added to the tournament without
                 creating a new player record. A player_id of 0 means the player is
                 new and needs to be created. Defaults to 0.
    """


def playerStandings(tournament=0):
    """Returns a list of the players and their win records for a specified tournament.
    Also indicates number of draws. Sorted based on winning percentage.
    A draw counts as 1/2 a win.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, draws, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        draws: the number of draws the player has
        matches: the number of matches the player has played

    Args:
      tournament: (optional) specifies which tournament to get the standings for.
                 Specify 0 to get the results of the most recent tournament.
                 Defaults to 0 if not specified.
    """


def reportMatch(winner, loser, draw=False, tournament=0):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won. *(see note regarding draws below)
      loser:  the id number of the player who lost. *(see note regarding draws below)
      draw: (optional) specifies if the match was a draw.
      tournament: (optional) specifies which tournament the match was played in.
                 Specify 0 to report a match for the most recent tournament.
                 Defaults to 0 if not specified.

    Note:
      * If the match is a draw, the args 'winner' and 'loser' are just used to identify
      the two different players. The result will be recorded as a draw for both players,
      rather than a win or loss.
    """


def swissPairings(tournament=0):
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.

    If there are an odd number of players, one player will receive a bye, which will
    count as an automatic win. A player may only receive one bye per tournament.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id. Set to 0 in the case of a bye.
        name2: the second player's name. Set to 'Bye' in the case of a bye.

    Args:
      tournament: (optional) specifies which tournament to get the standings for.
                 Specify 0 to get the results of the most recent tournament.
                 Defaults to 0 if not specified.

    """

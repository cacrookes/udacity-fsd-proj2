-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Stores player names with their ids. There can be duplicate names.
CREATE TABLE IF NOT EXISTS players (
  player_id   serial PRIMARY KEY,
  name        text
);

-- Lists which players are registered for each tournament, and stores whether
-- the player has had a bye in the tournament or not.
CREATE TABLE IF NOT EXISTS tournament_roster (
  tournament_id integer,
  player_id     integer REFERENCES players,
  had_bye       boolean DEFAULT FALSE,
  PRIMARY KEY (tournament_id, player_id)
);

-- Stores results of all matches for all tournament_matches
-- Indicates players in the match, whether the match was a draw, and if the
-- match was not a draw, indicates the winner. The winner field can be null
-- in the case when 'draw' is true.
CREATE TABLE IF NOT EXISTS tournament_matches (
  tournament_id integer,
  match_id      serial,
  player1_id    integer,
  player2_id    integer,
  draw          boolean DEFAULT FALSE,
  winner_id     integer DEFAULT NULL,
  CONSTRAINT check_winner CHECK((draw AND winner_id IS NULL) OR (NOT draw AND winner_id IS NOT NULL)),
  FOREIGN KEY (tournament_id, player1_id) REFERENCES tournament_roster,
  FOREIGN KEY (tournament_id, player2_id) REFERENCES tournament_roster,
  PRIMARY KEY (tournament_id, match_id)
);

-- Aggregates data for each player in each tournament, including number of wins,
-- draws, matches, and points. Points are calculated as 2 points per win, 1 per draw.
-- Results are sorted by tournament, and then by point totals inside each tournament.
CREATE VIEW player_rankings as
  SELECT tr.tournament_id,
         tr.player_id,
         COUNT(CASE WHEN tr.player_id = tm.player1_id OR tr.player_id = tm.player2_id THEN 1 END) AS matches,
         COUNT(CASE WHEN tm.winner_id = tr.player_id THEN 1 END) AS wins,
         COUNT(CASE WHEN tm.draw = true THEN 1 END) AS draws,
         SUM(CASE WHEN tm.winner_id = tr.player_id THEN 2 WHEN tm.draw = true THEN 1 END) AS points
         FROM tournament_roster tr LEFT JOIN tournament_matches tm
         ON tm.tournament_id = tr.tournament_id
         AND (tr.player_id = tm.player1_id OR tr.player_id = tm.player2_id)
         GROUP BY tr.player_id, tr.tournament_id
         ORDER BY tournament_id ASC, points DESC;

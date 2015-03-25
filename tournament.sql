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
  match_id      integer,
  player1_id    integer,
  player2_id    integer,
  draw          boolean DEFAULT FALSE,
  winner_id     integer,
  CONSTRAINT check_winner CHECK((draw AND winner_id IS NULL) OR (NOT draw AND winner_id IS NOT NULL)),
  FOREIGN KEY (tournament_id, player1_id) REFERENCES tournament_roster,
  FOREIGN KEY (tournament_id, player2_id) REFERENCES tournament_roster,
  PRIMARY KEY (tournament_id, match_id)
);

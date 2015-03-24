-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Stores player names with their ids. There can be duplicate names.
CREATE TABLE players {
  player_id   integer PRIMARY KEY,
  name        text
};

-- Stores results of all matches for all tournament_matches
-- Indicates players in the match, whether the match was a draw, and if the
-- match was not a draw, indicates the winner. The winner field can be null
-- in the case when 'draw' is true.
CREATE TABLE tournament_matches {
  tournament_id integer,
  match_id      integer,
  player1_id    integer REFERENCES players (player_id),
  player2_id    integer REFERENCES players (player_id),
  draw          boolean DEFAULT FALSE,
  winner_id     integer,
  CONSTRAINT ((draw AND winner_id IS NULL) OR (NOT draw AND winner_id NOT NULL)
  PRIMARY KEY (tournament_id, match_id)
};

-- Lists which players are registered for each tournament, and stores whether
-- the player has had a bye in the tournament or not.
CREATE TABLE tournament_roster {
  tournament_id integer REFERENCES tournament_matches,
  player_id     integer REFERENCES players,
  had_bye       boolean DEFAULT FALSE,
  PRIMARY KEY (tournament_id, player_id)
};

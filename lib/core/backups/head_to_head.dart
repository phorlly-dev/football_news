import 'package:football_news/core/backups/fixture.dart';
import 'package:football_news/core/backups/goals.dart';
import 'package:football_news/core/backups/league.dart';
import 'package:football_news/core/backups/score.dart';
import 'package:football_news/core/backups/teams.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class HeadToHead {
  HeadToHead({this.fixture, this.league, this.teams, this.goals, this.score});

  final Fixture? fixture;
  final League? league;
  final Teams? teams;
  final Goals? goals;
  final Score? score;

  HeadToHead copyWith({
    Fixture? fixture,
    League? league,
    Teams? teams,
    Goals? goals,
    Score? score,
  }) {
    return HeadToHead(
      fixture: fixture ?? this.fixture,
      league: league ?? this.league,
      teams: teams ?? this.teams,
      goals: goals ?? this.goals,
      score: score ?? this.score,
    );
  }

  factory HeadToHead.fromJson(Map<String, dynamic> json) {
    return HeadToHead(
      fixture: safeParse<Fixture>(json["fixture"], Fixture.fromJson),
      league: safeParse<League>(json["league"], League.fromJson),
      teams: safeParse<Teams>(json["teams"], Teams.fromJson),
      goals: safeParse<Goals>(json["goals"], Goals.fromJson),
      score: safeParse<Score>(json["score"], Score.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {
    "fixture": fixture?.toJson(),
    "league": league?.toJson(),
    "teams": teams?.toJson(),
    "goals": goals?.toJson(),
    "score": score?.toJson(),
  };
}

import 'package:football_news/core/backups/event.dart';
import 'package:football_news/core/backups/fixture.dart';
import 'package:football_news/core/backups/goals.dart';
import 'package:football_news/core/backups/league.dart';
import 'package:football_news/core/backups/score.dart';
import 'package:football_news/core/backups/teams.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Matches {
  Matches({
    required this.events,
    this.fixture,
    this.goals,
    this.league,
    this.score,
    this.teams,
  });

  final List<Event> events;
  final Fixture? fixture;
  final Goals? goals;
  final League? league;
  final Score? score;
  final Teams? teams;

  Matches copyWith({
    List<Event>? events,
    Fixture? fixture,
    Goals? goals,
    League? league,
    Score? score,
    Teams? teams,
  }) {
    return Matches(
      events: events ?? this.events,
      fixture: fixture ?? this.fixture,
      goals: goals ?? this.goals,
      league: league ?? this.league,
      score: score ?? this.score,
      teams: teams ?? this.teams,
    );
  }

  factory Matches.fromJson(Map<String, dynamic> json) => Matches(
    events: parseJsonList<Event>(json["events"], Event.fromJson),
    fixture: safeParse<Fixture>(json["fixture"], Fixture.fromJson),
    goals: safeParse<Goals>(json["goals"], Goals.fromJson),
    league: safeParse<League>(json["league"], League.fromJson),
    score: safeParse<Score>(json["score"], Score.fromJson),
    teams: safeParse<Teams>(json["teams"], Teams.fromJson),
  );

  Map<String, dynamic> toJson() => {
    "events": events.map((x) => x.toJson()).toList(),
    "fixture": fixture?.toJson(),
    "goals": goals?.toJson(),
    "league": league?.toJson(),
    "score": score?.toJson(),
    "teams": teams?.toJson(),
  };

  // for easier UI access
  DateTime get time => fixture?.date ?? DateTime.now();
  String get leagueName => league?.name ?? 'Unkown';
  String get round => league?.round ?? 'Unkown';
  String get homeTeam => teams?.home?.name ?? 'Unkown';
  String get awayTeam => teams?.away?.name ?? 'Unkown';
  String get homeLogo => teams?.home?.logo ?? 'Unkown';
  String get awayLogo => teams?.away?.logo ?? 'Unkown';
}

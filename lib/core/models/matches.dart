import 'package:football_news/core/models/event.dart';
import 'package:football_news/core/models/fixture.dart';
import 'package:football_news/core/models/goals.dart';
import 'package:football_news/core/models/league.dart';
import 'package:football_news/core/models/score.dart';
import 'package:football_news/core/models/teams.dart';

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

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      events: json["events"] == null
          ? []
          : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
      fixture: json["fixture"] == null
          ? null
          : Fixture.fromJson(json["fixture"]),
      goals: json["goals"] == null ? null : Goals.fromJson(json["goals"]),
      league: json["league"] == null ? null : League.fromJson(json["league"]),
      score: json["score"] == null ? null : Score.fromJson(json["score"]),
      teams: json["teams"] == null ? null : Teams.fromJson(json["teams"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "events": events.map((x) => x.toJson()).toList(),
    "fixture": fixture?.toJson(),
    "goals": goals?.toJson(),
    "league": league?.toJson(),
    "score": score?.toJson(),
    "teams": teams?.toJson(),
  };
}

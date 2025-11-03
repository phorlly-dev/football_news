import 'package:football_news/core/backups/player.dart';
import 'package:football_news/core/backups/team.dart';
import 'package:football_news/core/backups/time.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Event {
  Event({
    this.detail,
    this.player,
    this.team,
    this.time,
    this.type,
    this.assist,
    this.comments,
  });

  final String? detail;
  final Player? player;
  final Team? team;
  final Time? time;
  final String? type;
  final Player? assist;
  final Object? comments;

  Event copyWith({
    String? detail,
    Player? player,
    Team? team,
    Time? time,
    String? type,
    Player? assist,
    Object? comments,
  }) {
    return Event(
      detail: detail ?? this.detail,
      player: player ?? this.player,
      team: team ?? this.team,
      time: time ?? this.time,
      type: type ?? this.type,
      assist: assist ?? this.assist,
      comments: comments ?? this.comments,
    );
  }

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    detail: json["detail"],
    player: parseModel<Player>(json["player"], Player.fromJson),
    team: parseModel<Team>(json["team"], Team.fromJson),
    time: parseModel<Time>(json["time"], Time.fromJson),
    type: json["type"],
    assist: parseModel<Player>(json["assist"], Player.fromJson),
    comments: json['comments'] ?? [],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
    "player": player?.toJson(),
    "team": team?.toJson(),
    "time": time?.toJson(),
    "type": type,
    "assist": assist?.toJson(),
    'comments': comments ?? [],
  };
}

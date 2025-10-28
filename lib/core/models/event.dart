import 'package:football_news/core/models/assist.dart';
import 'package:football_news/core/models/away.dart';
import 'package:football_news/core/models/time.dart';

class Event {
  Event({
    this.detail,
    this.player,
    this.team,
    this.time,
    this.type,
    this.assist,
  });

  final String? detail;
  final Assist? player;
  final Away? team;
  final Time? time;
  final String? type;
  final Assist? assist;

  Event copyWith({
    String? detail,
    Assist? player,
    Away? team,
    Time? time,
    String? type,
    Assist? assist,
  }) {
    return Event(
      detail: detail ?? this.detail,
      player: player ?? this.player,
      team: team ?? this.team,
      time: time ?? this.time,
      type: type ?? this.type,
      assist: assist ?? this.assist,
    );
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      detail: json["detail"],
      player: json["player"] == null ? null : Assist.fromJson(json["player"]),
      team: json["team"] == null ? null : Away.fromJson(json["team"]),
      time: json["time"] == null ? null : Time.fromJson(json["time"]),
      type: json["type"],
      assist: json["assist"] == null ? null : Assist.fromJson(json["assist"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "detail": detail,
    "player": player?.toJson(),
    "team": team?.toJson(),
    "time": time?.toJson(),
    "type": type,
    "assist": assist?.toJson(),
  };
}

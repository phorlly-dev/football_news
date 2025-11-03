import 'package:football_news/core/backups/team_color.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Colors {
  Colors({this.player, this.goalkeeper});

  final TeamColor? player;
  final TeamColor? goalkeeper;

  Colors copyWith({TeamColor? player, TeamColor? goalkeeper}) {
    return Colors(
      player: player ?? this.player,
      goalkeeper: goalkeeper ?? this.goalkeeper,
    );
  }

  factory Colors.fromJson(Map<String, dynamic> json) {
    return Colors(
      player: safeParse<TeamColor>(json["player"], TeamColor.fromJson),
      goalkeeper: safeParse<TeamColor>(json["goalkeeper"], TeamColor.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {
    "player": player?.toJson(),
    "goalkeeper": goalkeeper?.toJson(),
  };
}

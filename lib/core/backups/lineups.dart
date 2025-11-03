import 'package:football_news/core/backups/player.dart';
import 'package:football_news/core/backups/team.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Lineups {
  Lineups({
    this.coach,
    required this.startXI,
    required this.substitutes,
    this.team,
    this.formation,
  });

  final String? formation;
  final Team? team;
  final Player? coach;
  final List<Player> startXI;
  final List<Player> substitutes;

  Lineups copyWith({
    Team? team,
    String? formation,
    Player? coach,
    List<Player>? startXI,
    List<Player>? substitutes,
  }) {
    return Lineups(
      team: team ?? this.team,
      formation: formation ?? this.formation,
      coach: coach ?? this.coach,
      startXI: startXI ?? this.startXI,
      substitutes: substitutes ?? this.substitutes,
    );
  }

  factory Lineups.fromJson(Map<String, dynamic> json) {
    return Lineups(
      team: safeParse<Team>(json["team"], Team.fromJson),
      coach: safeParse<Player>(json["coach"], Player.fromJson),
      formation: json['formation'] ?? '',
      startXI: parseJsonList<Player>(json["startXI"], Player.fromJson),
      substitutes: parseJsonList<Player>(json["substitutes"], Player.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {"team": team, "formation": formation};
}

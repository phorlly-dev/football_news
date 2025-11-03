import 'package:football_news/core/backups/team_color.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Team {
  Team({
    this.update,
    this.id,
    this.logo,
    this.name,
    this.winner = false,
    this.colors,
  });

  final int? id;
  final String? logo;
  final String? name;
  final bool winner;
  final TeamColor? colors;
  final DateTime? update;

  Team copyWith({
    int? id,
    String? logo,
    String? name,
    bool? winner,
    TeamColor? colors,
    DateTime? update,
  }) {
    return Team(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      name: name ?? this.name,
      winner: winner ?? this.winner,
      colors: colors ?? this.colors,
      update: update ?? this.update,
    );
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json["id"],
      logo: json["logo"],
      name: json["name"],
      winner: json["winner"] ?? false,
      colors: safeParse<TeamColor>(json['colors'], TeamColor.fromJson),
      update: DateTime.tryParse(json['update'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo": logo,
    "name": name,
    "winner": winner,
    'colors': colors,
    'update': update,
  };
}

import 'package:football_news/core/backups/team.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Teams {
  Teams({this.away, this.home});

  final Team? away;
  final Team? home;

  Teams copyWith({Team? away, Team? home}) {
    return Teams(away: away ?? this.away, home: home ?? this.home);
  }

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: safeParse(json["home"], Team.fromJson),
      away: safeParse(json["away"], Team.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {
    "away": away?.toJson(),
    "home": home?.toJson(),
  };
}

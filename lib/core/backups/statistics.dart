import 'package:football_news/core/backups/statistic.dart';
import 'package:football_news/core/backups/team.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Statistics {
  Statistics({this.statistics, this.team});

  final Statistic? statistics;
  final Team? team;

  Statistics copyWith({Statistic? statistics, Team? team}) {
    return Statistics(
      statistics: statistics ?? this.statistics,
      team: team ?? this.team,
    );
  }

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      statistics: safeParse<Statistic>(json["statistics"], Statistic.fromJson),
      team: safeParse<Team>(json["team"], Team.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {"statistics": statistics, "team": team};
}

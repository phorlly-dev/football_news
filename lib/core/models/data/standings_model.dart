import 'package:football_news/core/models/domain/standings.dart';
import 'package:football_news/core/models/domain/team_rank.dart';
import 'package:football_news/core/models/mappers/mappers.dart';
import 'package:football_news/core/models/data/team_rank_model.dart';

class StandingsModel extends Standings {
  const StandingsModel({required super.standings, super.groups});

  factory StandingsModel.fromJson(Map<dynamic, dynamic> json) => StandingsModel(
    standings: List<TeamRank>.from(
      json['rows'].map((item) {
        return TeamRankModel.fromJson(item).toDomain();
      }).toList(),
    ),
    groups: json['groups'] != null
        ? List<StandingsGroup>.from(
            json['groups'].map((item) {
              return StandingsGroupModel.fromJson(item);
            }).toList(),
          )
        : null,
  );
}

class StandingsGroupModel extends StandingsGroup {
  const StandingsGroupModel({required super.name, required super.number});

  factory StandingsGroupModel.fromJson(Map<String, dynamic> json) =>
      StandingsGroupModel(
        name: json['name'],
        number: (json['num'] as num).toInt(),
      );
}

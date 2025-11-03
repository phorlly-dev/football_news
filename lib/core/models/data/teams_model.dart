import 'package:football_news/core/models/domain/teams.dart';
import 'package:football_news/core/models/data/lineups_model.dart';
import 'package:football_news/core/utils/app_constants.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class TeamsModel extends Teams {
  const TeamsModel({required super.home, required super.away});

  factory TeamsModel.fromJson(Map<String, dynamic> json) => TeamsModel(
    home: castToMap<TeamModel>(json['homeCompetitor'], TeamModel.fromJson),
    away: castToMap<TeamModel>(json['awayCompetitor'], TeamModel.fromJson),
  );
}

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.logo,
    super.color,
    super.awayColor,
    super.score,
    super.aggregatedScore,
    super.lineup,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return TeamModel(
      id: id,
      name: json['name'],
      logo: AppConstants.clubImage(id.toString()),
      color: json['color'],
      awayColor: json['awayColor'],
      score: (json['score'] as num?)?.toInt() ?? -1,
      aggregatedScore: (json['aggregatedScore'] as num?)?.toInt(),
      lineup: json['lineups'] != null
          ? LineupModel.fromJson(json['lineups'])
          : null,
    );
  }
}

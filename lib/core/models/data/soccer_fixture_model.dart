import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/models/domain/soccer_fixture.dart';
import 'package:football_news/core/models/mappers/mappers.dart';
import 'package:football_news/core/models/data/teams_model.dart';

class SoccerFixtureModel extends SoccerFixture {
  const SoccerFixtureModel({
    required super.id,
    required super.teams,
    required super.statusText,
    required super.gameTimeAndStatusDisplayType,
    super.fixtureLeague,
    super.startTime,
    super.gameTime,
    super.addedTime,
    super.gameTimeDisplay = '',
    super.roundNum,
    super.stageNum,
    super.seasonNum,
    super.competitionId,
  });

  factory SoccerFixtureModel.fromJson(
    Map<String, dynamic> json, {
    League? fixtureLeague,
  }) => SoccerFixtureModel(
    id: json['id'],
    teams: TeamsModel.fromJson(json).toDomain(),
    fixtureLeague: fixtureLeague,
    statusText: json['statusText'],
    gameTimeAndStatusDisplayType: (json['gameTimeAndStatusDisplayType'] as num)
        .toInt(),
    startTime: DateTime.parse(json['startTime']),
    gameTime: (json['gameTime'] as num?)?.toInt(),
    addedTime: (json['addedTime'] as num?)?.toInt(),
    gameTimeDisplay: json['gameTimeDisplay'] ?? '',
    roundNum: json['roundNum'],
    stageNum: json['stageNum'],
    seasonNum: json['seasonNum'],
    competitionId: json['competitionId'],
  );
}

import 'package:equatable/equatable.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/models/domain/teams.dart';
import 'package:football_news/core/utils/enums.dart';

class SoccerFixture extends Equatable {
  final int id;
  final Teams teams;
  final String statusText;
  final int gameTimeAndStatusDisplayType;
  final League? fixtureLeague;
  final DateTime? startTime;
  final int? gameTime;
  final int? addedTime;
  final String gameTimeDisplay;
  final int? roundNum;
  final int? stageNum;
  final int? seasonNum, competitionId;

  const SoccerFixture({
    this.competitionId,
    required this.id,
    required this.teams,
    required this.statusText,
    required this.gameTimeAndStatusDisplayType,
    this.fixtureLeague,
    this.startTime,
    this.gameTime,
    this.addedTime,
    this.gameTimeDisplay = '',
    this.roundNum,
    this.stageNum,
    this.seasonNum,
  });

  @override
  List<Object?> get props => [
    id,
    fixtureLeague,
    teams,
    statusText,
    startTime,
    gameTime,
    roundNum,
    stageNum,
    seasonNum,
    competitionId,
  ];

  SoccerFixtureStatus get status {
    if (gameTimeAndStatusDisplayType == 1 &&
        (gameTime != null && gameTime! < 90)) {
      return SoccerFixtureStatus.live;
    }
    return switch (gameTimeAndStatusDisplayType) {
      1 => SoccerFixtureStatus.ended,
      0 => SoccerFixtureStatus.scheduled,
      2 => SoccerFixtureStatus.live,
      _ => SoccerFixtureStatus.scheduled,
    };
  }
}

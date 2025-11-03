import 'package:football_news/core/models/domain/event.dart';
import 'package:football_news/core/models/domain/goals.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/models/domain/lineups.dart';
import 'package:football_news/core/models/domain/player.dart';
import 'package:football_news/core/models/domain/soccer_fixture.dart';
import 'package:football_news/core/models/domain/standings.dart';
import 'package:football_news/core/models/domain/status.dart';
import 'package:football_news/core/models/domain/team_rank.dart';
import 'package:football_news/core/models/domain/teams.dart';
import 'package:football_news/core/models/data/event_model.dart';
import 'package:football_news/core/models/data/goals_model.dart';
import 'package:football_news/core/models/data/league_model.dart';
import 'package:football_news/core/models/data/lineups_model.dart';
import 'package:football_news/core/models/data/player_model.dart';
import 'package:football_news/core/models/data/soccer_fixture_model.dart';
import 'package:football_news/core/models/data/standings_model.dart';
import 'package:football_news/core/models/data/status_model.dart';
import 'package:football_news/core/models/data/team_rank_model.dart';
import 'package:football_news/core/models/data/teams_model.dart';

extension StatusExtension on StatusModel {
  Status toDomain() => Status(long: long, short: short, elapsed: elapsed);
}

extension TeamExtension on TeamModel {
  Team toDomain() => Team(
    id: id,
    name: name,
    logo: logo,
    color: color,
    awayColor: awayColor,
    score: score,
    aggregatedScore: aggregatedScore,
  );
}

extension TeamsExtension on TeamsModel {
  Teams toDomain() => Teams(home: home, away: away);
}

extension GoalsExtension on GoalsModel {
  Goals toDomain() => Goals(home: home, away: away);
}

extension SoccerFixtureExtension on SoccerFixtureModel {
  SoccerFixture toDomain() => SoccerFixture(
    id: id,
    fixtureLeague: fixtureLeague,
    teams: teams,
    statusText: statusText,
    gameTimeAndStatusDisplayType: gameTimeAndStatusDisplayType,
    startTime: startTime,
    gameTime: gameTime,
    addedTime: addedTime,
    gameTimeDisplay: gameTimeDisplay,
    roundNum: roundNum,
    stageNum: stageNum,
    seasonNum: seasonNum,
  );
}

extension LeagueExtension on LeagueModel {
  League toDomain() {
    return League(
      id: id,
      name: name,
      logo: logo,
      country: country,
      color: color,
    );
  }
}

extension PlayerExtension on PlayerModel {
  Player toDomain() => Player(
    id: id,
    name: name,
    number: number,
    competitorId: competitorId,
    shortName: shortName,
    nameForURL: nameForURL,
  );
}

extension LineupExtension on LineupModel {
  Lineup toDomain() {
    return Lineup(formation: formation, status: status, members: members);
  }
}

extension EventExtension on EventModel {
  Event toDomain() {
    return Event(
      addedTime: addedTime,
      gameTime: gameTime,
      gameTimeAndStatusDisplayType: gameTimeAndStatusDisplayType,
      gameTimeDisplay: gameTimeDisplay,
      order: order,
      playerId: playerId,
      teamId: teamId,
      type: type,
    );
  }
}

extension TeamRankExtension on TeamRankModel {
  TeamRank toDomain() => TeamRank(
    rank: rank,
    team: team,
    points: points,
    goalsDiff: goalsDiff,
    form: form,
    stats: stats,
    groupNum: groupNum,
  );
}

extension TeamRankStatsExtension on TeamRankStatsModel {
  TeamRankStats toDomain() => TeamRankStats(
    played: played,
    win: win,
    draw: draw,
    lose: lose,
    scored: scored,
    received: received,
  );
}

extension StandingsExtension on StandingsModel {
  Standings toDomain() => Standings(standings: standings);
}

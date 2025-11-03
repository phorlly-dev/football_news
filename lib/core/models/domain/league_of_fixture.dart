import 'package:equatable/equatable.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/models/domain/soccer_fixture.dart';

class LeagueOfFixture extends Equatable {
  final List<SoccerFixture> fixtures = [];
  final League league;

  LeagueOfFixture({required this.league});

  @override
  List<Object?> get props => [league, fixtures];
}

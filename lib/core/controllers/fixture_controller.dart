import 'package:football_news/core/controllers/controller.dart';
import 'package:football_news/core/controllers/league_controller.dart';
import 'package:football_news/core/models/data/soccer_fixture_model.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/models/domain/soccer_fixture.dart';
import 'package:football_news/core/models/mappers/mappers.dart';
import 'package:football_news/core/utils/app_constants.dart';
import 'package:get/get.dart';

class FixtureController extends Controller<SoccerFixture> {
  FixtureController()
    : super(
        path: 'live_score/live/games',
        fromJson: (json) => SoccerFixtureModel.fromJson(json).toDomain(),
      );

  final _leagueCtrl = Get.put(LeagueController());

  @override
  void onInit() {
    super.onInit();
    listenToFixture();
  }

  Future<void> listenToFixture() async {
    final leagues = await _leagueCtrl.fetchLeagues();
    ref.onValue.listen((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists) {
        items.clear();
        return;
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final fixtures = data.entries.map((entry) {
        final id = int.tryParse(entry.key) ?? 0;
        final json = Map<String, dynamic>.from(entry.value);
        json['id'] = id;

        return SoccerFixtureModel.fromJson(
          json,
          fixtureLeague: leagues[json['competitionId']],
        ).toDomain();
      }).toList();

      items.assignAll(fixtures);
    });
  }

  RxList<League> get leagues => _leagueCtrl.items;
  List<League> get visibleLeagues {
    final order = AppConstants.availableLeagues;
    return leagues.where((l) => order.contains(l.id)).toList()
      ..sort((a, b) => order.indexOf(a.id).compareTo(order.indexOf(b.id)));
  }
}

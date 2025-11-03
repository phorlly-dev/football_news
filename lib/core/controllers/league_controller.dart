import 'package:football_news/core/controllers/controller.dart';
import 'package:football_news/core/controllers/country_controller.dart';
import 'package:football_news/core/models/data/league_model.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/models/mappers/mappers.dart';
import 'package:get/get.dart';

class LeagueController extends Controller<League> {
  LeagueController()
    : super(
        path: 'live_score/meta/competitions',
        fromJson: (json) => LeagueModel.fromJson(json).toDomain(),
      );

  @override
  void onInit() {
    super.onInit();
    listenToLeagues();
  }

  Future<void> listenToLeagues() async {
    final countries = await Get.put(CountryController()).fetchCountries();
    ref.onValue.listen((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists) {
        items.clear();
        return;
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final leagues = data.entries.map((entry) {
        final id = int.tryParse(entry.key) ?? 0;
        final json = Map<String, dynamic>.from(entry.value);
        json['id'] = id;

        return LeagueModel.fromJson(
          json,
          country: countries[json['countryId']],
        ).toDomain();
      }).toList();

      items.assignAll(leagues);
    });
  }

  Future<Map<int, LeagueModel>> fetchLeagues() async {
    final snapshot = await ref.get();
    if (!snapshot.exists) return {};

    final map = Map<String, dynamic>.from(snapshot.value as Map);
    return map.map((key, value) {
      final id = int.tryParse(key) ?? 0;

      return MapEntry(
        id,
        LeagueModel.fromJson(Map<String, dynamic>.from(value)),
      );
    });
  }
}

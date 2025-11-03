import 'package:football_news/core/controllers/controller.dart';
import 'package:football_news/core/backups/league.dart';
import 'package:get/get.dart';

class LeagueControllerX extends Controller<League> {
  LeagueControllerX()
    : super(
        path: 'matches',
        fromJson: (json) => League.fromJson(json['league']),
      );

  @override
  void binds() {
    ref.onValue.listen((event) {
      final raw = event.snapshot.value;
      if (raw == null) {
        items.clear();
        return;
      }

      final data = (raw is Map)
          ? Map<String, dynamic>.from(raw)
          : {for (int i = 0; i < (raw as List).length; i++) '$i': raw[i]};

      final uniqueLeagues = <int, League>{};

      for (var matchData in data.values) {
        if (matchData is Map && matchData['league'] != null) {
          final league = League.fromJson(
            Map<String, dynamic>.from(matchData['league']),
          );
          uniqueLeagues[league.id ?? uniqueLeagues.length + 1] = league;
        }
      }

      items.assignAll(uniqueLeagues.values.toList());
    });
  }

  bool _listening = false;

  @override
  void onInit() {
    if (!_listening) {
      binds();
      _listening = true;
    }
    super.onInit();
  }
}

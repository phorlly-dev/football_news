import 'package:football_news/core/controllers/controller.dart';
import 'package:football_news/core/models/data/country_model.dart';
import 'package:football_news/core/models/domain/country.dart';

class CountryController extends Controller<Country> {
  CountryController()
    : super(
        path: 'live_score/meta/countries',
        fromJson: (json) => CountryModel.fromJson(json),
      );

  Future<Map<int, CountryModel>> fetchCountries() async {
    final snapshot = await ref.get();
    if (!snapshot.exists) return {};

    final map = Map<String, dynamic>.from(snapshot.value as Map);
    return map.map((key, value) {
      final id = int.tryParse(key) ?? 0;

      return MapEntry(
        id,
        CountryModel.fromJson(Map<String, dynamic>.from(value)),
      );
    });
  }
}

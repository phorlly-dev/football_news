import 'package:football_news/core/models/domain/country.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/core/utils/app_constants.dart';

class LeagueModel extends League {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.logo,
    super.country,
    super.color,
    super.countryId,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json, {Country? country}) {
    final id = json['id'];
    return LeagueModel(
      id: id,
      name: json['name'],
      logo: AppConstants.competitionImage(id),
      country: country,
      color: json['color'],
      countryId: json['countryId'],
    );
  }
}

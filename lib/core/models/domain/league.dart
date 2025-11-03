import 'package:equatable/equatable.dart';
import 'package:football_news/core/models/domain/country.dart';
import 'package:football_news/core/utils/app_constants.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String logo;
  final Country? country;
  final String? color;
  final int? countryId;

  const League({
    this.countryId,
    required this.id,
    required this.name,
    required this.logo,
    this.country,
    this.color,
  });

  /// Factory for a lightweight league (fixture use case)
  factory League.light({required int id, required String name}) {
    return League(
      id: id,
      name: name,
      logo: AppConstants.competitionImage(id), // derived logo
    );
  }

  @override
  List<Object?> get props => [id, name, logo, country, color, countryId];
}

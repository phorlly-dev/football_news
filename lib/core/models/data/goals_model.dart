import 'package:football_news/core/models/domain/goals.dart';

class GoalsModel extends Goals {
  const GoalsModel({required super.home, required super.away});

  factory GoalsModel.fromJson(Map<String, dynamic> json) =>
      GoalsModel(home: json['home'], away: json['away']);
}

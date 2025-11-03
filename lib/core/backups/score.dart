import 'package:football_news/core/backups/goals.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Score {
  Score({this.extratime, this.penalty, this.halftime, this.fulltime});

  final Goals? halftime;
  final Goals? fulltime;
  final Goals? extratime;
  final Goals? penalty;

  Score copyWith({
    Goals? halftime,
    Goals? fulltime,
    Goals? extratime,
    Goals? penalty,
  }) {
    return Score(
      halftime: halftime ?? this.halftime,
      fulltime: fulltime ?? this.fulltime,
      extratime: extratime ?? this.extratime,
      penalty: penalty ?? this.penalty,
    );
  }

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halftime: parseModel<Goals>(json["halftime"], Goals.fromJson),
      fulltime: parseModel<Goals>(json["fulltime"], Goals.fromJson),
      extratime: parseModel<Goals>(json["extratime"], Goals.fromJson),
      penalty: parseModel<Goals>(json["penalty"], Goals.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {
    "halftime": halftime?.toJson(),
    "fulltime": fulltime?.toJson(),
    "extratime": extratime?.toJson(),
    "penalty": penalty?.toJson(),
  };
}

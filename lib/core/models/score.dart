import 'package:football_news/core/models/goals.dart';

class Score {
  Score({this.halftime});

  final Goals? halftime;

  Score copyWith({Goals? halftime}) {
    return Score(halftime: halftime ?? this.halftime);
  }

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halftime: json["halftime"] == null
          ? null
          : Goals.fromJson(json["halftime"]),
    );
  }

  Map<String, dynamic> toJson() => {"halftime": halftime?.toJson()};
}

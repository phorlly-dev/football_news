import 'package:football_news/core/models/away.dart';

class Teams {
  Teams({this.away, this.home});

  final Away? away;
  final Away? home;

  Teams copyWith({Away? away, Away? home}) {
    return Teams(away: away ?? this.away, home: home ?? this.home);
  }

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      away: json["away"] == null ? null : Away.fromJson(json["away"]),
      home: json["home"] == null ? null : Away.fromJson(json["home"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "away": away?.toJson(),
    "home": home?.toJson(),
  };
}

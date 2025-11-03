class Goals {
  Goals({this.away, this.home});

  final int? home;
  final int? away;

  Goals copyWith({int? away, int? home}) {
    return Goals(away: away ?? this.away, home: home ?? this.home);
  }

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(away: json["away"] ?? 0, home: json["home"] ?? 0);
  }

  Map<String, dynamic> toJson() => {"away": away, "home": home};
}

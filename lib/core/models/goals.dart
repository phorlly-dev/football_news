class Goals {
  Goals({this.away, this.home});

  final int? away;
  final int? home;

  Goals copyWith({int? away, int? home}) {
    return Goals(away: away ?? this.away, home: home ?? this.home);
  }

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(away: json["away"], home: json["home"]);
  }

  Map<String, dynamic> toJson() => {"away": away, "home": home};
}

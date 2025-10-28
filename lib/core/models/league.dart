class League {
  League({
    this.country,
    this.flag,
    this.id,
    this.logo,
    this.name,
    this.round,
    this.season,
    this.standings,
  });

  final String? country;
  final String? flag;
  final int? id;
  final String? logo;
  final String? name;
  final String? round;
  final int? season;
  final bool? standings;

  League copyWith({
    String? country,
    String? flag,
    int? id,
    String? logo,
    String? name,
    String? round,
    int? season,
    bool? standings,
  }) {
    return League(
      country: country ?? this.country,
      flag: flag ?? this.flag,
      id: id ?? this.id,
      logo: logo ?? this.logo,
      name: name ?? this.name,
      round: round ?? this.round,
      season: season ?? this.season,
      standings: standings ?? this.standings,
    );
  }

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      country: json["country"],
      flag: json["flag"],
      id: json["id"],
      logo: json["logo"],
      name: json["name"],
      round: json["round"],
      season: json["season"],
      standings: json["standings"],
    );
  }

  Map<String, dynamic> toJson() => {
    "country": country,
    "flag": flag,
    "id": id,
    "logo": logo,
    "name": name,
    "round": round,
    "season": season,
    "standings": standings,
  };
}

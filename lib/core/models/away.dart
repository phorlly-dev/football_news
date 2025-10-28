class Away {
  Away({this.id, this.logo, this.name, this.winner = false});

  final int? id;
  final String? logo;
  final String? name;
  final bool winner;

  Away copyWith({int? id, String? logo, String? name, bool? winner}) {
    return Away(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      name: name ?? this.name,
      winner: winner ?? this.winner,
    );
  }

  factory Away.fromJson(Map<String, dynamic> json) {
    return Away(
      id: json["id"],
      logo: json["logo"],
      name: json["name"],
      winner: json["winner"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo": logo,
    "name": name,
    "winner": winner,
  };
}

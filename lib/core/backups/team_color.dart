class TeamColor {
  TeamColor({this.primary, this.number, this.border});

  final String? primary;
  final String? number;
  final String? border;

  TeamColor copyWith({String? primary, String? number, String? border}) {
    return TeamColor(
      primary: primary ?? this.primary,
      number: number ?? this.number,
      border: border ?? this.border,
    );
  }

  factory TeamColor.fromJson(Map<String, dynamic> json) {
    return TeamColor(
      primary: json["primary"],
      number: json["number"],
      border: json["border"],
    );
  }

  Map<String, dynamic> toJson() => {
    "primary": primary,
    "number": number,
    "border": border,
  };
}

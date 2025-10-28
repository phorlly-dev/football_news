class Periods {
  Periods({this.first, this.second});

  final int? first;
  final int? second;

  Periods copyWith({int? first, int? second}) {
    return Periods(first: first ?? this.first, second: second ?? this.second);
  }

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(first: json["first"], second: json["second"]);
  }

  Map<String, dynamic> toJson() => {"first": first, "second": second};
}

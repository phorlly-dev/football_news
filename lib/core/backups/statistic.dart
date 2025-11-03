class Statistic {
  Statistic({this.type, this.value});

  final String? type;
  final int? value;

  Statistic copyWith({String? type, int? value}) {
    return Statistic(type: type ?? this.type, value: value ?? this.value);
  }

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(type: json["type"], value: json["value"]);
  }

  Map<String, dynamic> toJson() => {"type": type, "value": value};
}

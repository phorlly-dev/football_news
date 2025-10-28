class Time {
  Time({this.elapsed});

  final int? elapsed;

  Time copyWith({int? elapsed}) {
    return Time(elapsed: elapsed ?? this.elapsed);
  }

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(elapsed: json["elapsed"]);
  }

  Map<String, dynamic> toJson() => {"elapsed": elapsed};
}

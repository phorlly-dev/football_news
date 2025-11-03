class Time {
  Time({this.extra, this.elapsed});

  final int? elapsed;
  final Object? extra;

  Time copyWith({int? elapsed, Object? extra}) {
    return Time(elapsed: elapsed ?? this.elapsed, extra: extra ?? this.extra);
  }

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(elapsed: json["elapsed"], extra: json['extra'] ?? []);
  }

  Map<String, dynamic> toJson() => {"elapsed": elapsed, 'extra': extra};
}

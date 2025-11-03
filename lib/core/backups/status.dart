class Status {
  Status({this.elapsed, this.long, this.short, this.extra});

  final int? elapsed;
  final String? long;
  final String? short;
  final Object? extra;

  Status copyWith({int? elapsed, String? long, String? short, Object? extra}) {
    return Status(
      elapsed: elapsed ?? this.elapsed,
      long: long ?? this.long,
      short: short ?? this.short,
      extra: extra ?? this.extra,
    );
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      elapsed: json["elapsed"],
      long: json["long"],
      short: json["short"],
      extra: json['extra'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    "elapsed": elapsed,
    "long": long,
    "short": short,
    'extra': extra ?? [],
  };
}

class Status {
  Status({this.elapsed, this.long, this.short});

  final int? elapsed;
  final String? long;
  final String? short;

  Status copyWith({int? elapsed, String? long, String? short}) {
    return Status(
      elapsed: elapsed ?? this.elapsed,
      long: long ?? this.long,
      short: short ?? this.short,
    );
  }

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      elapsed: json["elapsed"],
      long: json["long"],
      short: json["short"],
    );
  }

  Map<String, dynamic> toJson() => {
    "elapsed": elapsed,
    "long": long,
    "short": short,
  };
}

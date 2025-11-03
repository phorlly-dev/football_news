import 'package:football_news/core/backups/periods.dart';
import 'package:football_news/core/backups/status.dart';
import 'package:football_news/core/backups/venue.dart';
import 'package:football_news/core/utils/json_helpers.dart';

class Fixture {
  Fixture({
    this.date,
    this.referee,
    this.id,
    this.periods,
    this.status,
    this.timestamp,
    this.timezone,
    this.venue,
  });

  final int? id;
  final DateTime? date;
  final Periods? periods;
  final Status? status;
  final int? timestamp;
  final String? timezone;
  final Object? referee;
  final Venue? venue;

  Fixture copyWith({
    DateTime? date,
    int? id,
    Periods? periods,
    Status? status,
    int? timestamp,
    String? timezone,
    Venue? venue,
    Object? referee,
  }) {
    return Fixture(
      date: date ?? this.date,
      id: id ?? this.id,
      periods: periods ?? this.periods,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      timezone: timezone ?? this.timezone,
      venue: venue ?? this.venue,
      referee: referee ?? this.referee,
    );
  }

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      date: DateTime.tryParse(json["date"] ?? ""),
      id: json["id"],
      periods: parseModel<Periods>(json["periods"], Periods.fromJson),
      status: parseModel<Status>(json["status"], Status.fromJson),
      timestamp: json["timestamp"],
      timezone: json["timezone"],
      venue: parseModel<Venue>(json["venue"], Venue.fromJson),
      referee: json['referee'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "id": id,
    "periods": periods?.toJson(),
    "status": status?.toJson(),
    "timestamp": timestamp,
    "timezone": timezone,
    "venue": venue?.toJson(),
    'referee': referee ?? [],
  };
}

import 'package:football_news/core/models/periods.dart';
import 'package:football_news/core/models/status.dart';
import 'package:football_news/core/models/venue.dart';

class Fixture {
  Fixture({
    this.date,
    this.id,
    this.periods,
    this.status,
    this.timestamp,
    this.timezone,
    this.venue,
  });

  final DateTime? date;
  final int? id;
  final Periods? periods;
  final Status? status;
  final int? timestamp;
  final String? timezone;
  final Venue? venue;

  Fixture copyWith({
    DateTime? date,
    int? id,
    Periods? periods,
    Status? status,
    int? timestamp,
    String? timezone,
    Venue? venue,
  }) {
    return Fixture(
      date: date ?? this.date,
      id: id ?? this.id,
      periods: periods ?? this.periods,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      timezone: timezone ?? this.timezone,
      venue: venue ?? this.venue,
    );
  }

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      date: DateTime.tryParse(json["date"] ?? ""),
      id: json["id"],
      periods: json["periods"] == null
          ? null
          : Periods.fromJson(json["periods"]),
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      timestamp: json["timestamp"],
      timezone: json["timezone"],
      venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
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
  };
}

class Venue {
  Venue({this.city, this.id, this.name});

  final String? city;
  final int? id;
  final String? name;

  Venue copyWith({String? city, int? id, String? name}) {
    return Venue(
      city: city ?? this.city,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(city: json["city"], id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"city": city, "id": id, "name": name};
}

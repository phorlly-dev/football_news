class Assist {
  Assist({this.id, this.name});

  final int? id;
  final String? name;

  Assist copyWith({int? id, String? name}) {
    return Assist(id: id ?? this.id, name: name ?? this.name);
  }

  factory Assist.fromJson(Map<String, dynamic> json) {
    return Assist(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

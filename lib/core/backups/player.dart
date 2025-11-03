class Player {
  Player({this.number, this.pos, this.grid, this.photo, this.id, this.name});

  final int? id, number;
  final String? name, photo, pos, grid;

  Player copyWith({
    int? id,
    int? number,
    String? name,
    String? photo,
    String? pos,
    String? grid,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      number: id ?? this.number,
      pos: pos ?? this.pos,
      grid: grid ?? this.grid,
    );
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json["id"],
      number: json["number"] ?? 0,
      name: json["name"],
      photo: json['photo'] ?? '',
      pos: json['pos'] ?? '',
      grid: json['grid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    'number': number,
    "name": name,
    'pos': pos,
    'grid': grid,
  };
}

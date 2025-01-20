class SchoolEntity {
  int id;
  String name;
  String location;

  SchoolEntity({
    required this.id,
    required this.name,
    required this.location,
  });

  factory SchoolEntity.empty() => SchoolEntity(id: -1, name: "", location: "");

  factory SchoolEntity.fromJson(Map<String, dynamic> json) => SchoolEntity(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        location: json["location"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
      };
  static List<SchoolEntity> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, SchoolEntity>(
            json.map((x) => SchoolEntity.fromJson(x)).toList())
        : [];
  }
}

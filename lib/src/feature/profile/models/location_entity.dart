class LocationEntity {
  String id;
  String sortname;
  String name;
  String phonecode;
  String country;
  String state;

  LocationEntity({
    required this.id,
    required this.sortname,
    required this.name,
    required this.phonecode,
    required this.country,
    required this.state,
  });

  factory LocationEntity.empty() => LocationEntity(
      id: "", sortname: "", name: "", phonecode: "", country: "", state: "");

  factory LocationEntity.fromJson(Map<String, dynamic> json) => LocationEntity(
        id: json["id"] ?? "",
        sortname: json["sortname"] ?? "",
        name: json["name"] ?? "",
        phonecode: json["phonecode"] ?? "",
        country: json["country"] ?? "",
        state: json["state"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sortname": sortname,
        "name": name,
        "phonecode": phonecode,
        "country": country,
        "state": state,
      };

  static List<LocationEntity> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, LocationEntity>(
            json.map((x) => LocationEntity.fromJson(x)).toList())
        : [];
  }
}

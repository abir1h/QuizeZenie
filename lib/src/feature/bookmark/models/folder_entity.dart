class FolderEntity {
  String id;
  String name;

  FolderEntity({
    required this.id,
    required this.name,
  });
  factory FolderEntity.empty() => FolderEntity(id: "", name: "");

  factory FolderEntity.fromJson(Map<String, dynamic> json) => FolderEntity(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  static List<FolderEntity> listFromJson(List<dynamic> json){
    return json.isNotEmpty ? List.castFrom<dynamic,FolderEntity>(json.map((x)=> FolderEntity.fromJson(x)).toList()):[];
  }

}
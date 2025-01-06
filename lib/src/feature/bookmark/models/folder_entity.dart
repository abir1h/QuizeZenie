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
}
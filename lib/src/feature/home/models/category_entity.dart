class CategoryEntity {
  int id;
  String title;

  CategoryEntity({
    required this.id,
    required this.title,
  });

  factory CategoryEntity.empty() => CategoryEntity(
    id: -1,
    title: "",
  );

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
    id: json["id"]??-1,
    title: json["name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": title,
  };

  static List<CategoryEntity> listFromJson(List<dynamic> json){
    return json.isNotEmpty ? List.castFrom<dynamic,CategoryEntity>(json.map((x)=> CategoryEntity.fromJson(x)).toList()):[];
  }
}
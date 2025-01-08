import 'form_category.dart';

class FeedbackEntity {
  int id;
  String name;
  List<FormCategory> formCategories;
  String createdAt;
  String? choice;

  FeedbackEntity({
    required this.id,
    required this.name,
    required this.formCategories,
    required this.createdAt,
    this.choice,
  });
  factory FeedbackEntity.empty() =>
      FeedbackEntity(id: -1, name: "", createdAt: "", choice: "", formCategories: []);

  factory FeedbackEntity.fromJson(Map<String, dynamic> json) => FeedbackEntity(
    id: json["id"] ?? -1,
    name: json["name"] ?? "",
    formCategories: List<FormCategory>.from((json["form_categories"]??[]).map((x) => FormCategory.fromJson(x))),
    createdAt: json["created_at"] ?? "",
    choice: json["choice"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "form_categories": List<dynamic>.from(formCategories.map((x) => x.toJson())),
    "created_at": createdAt,
    "choice": choice,
  };
  static List<FeedbackEntity> listFromJson(List<dynamic> json){
    return json.isNotEmpty ? List.castFrom<dynamic,FeedbackEntity>(json.map((x)=> FeedbackEntity.fromJson(x)).toList()):[];
  }
}
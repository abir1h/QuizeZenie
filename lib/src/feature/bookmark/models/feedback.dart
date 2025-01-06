import 'form_category.dart';

class FeedbackEntity {
  int id;
  String name;
  List<FormCategory>? formCategories;
  String createdAt;
  String? choice;

  FeedbackEntity({
    required this.id,
    required this.name,
    this.formCategories,
    required this.createdAt,
    this.choice,
  });
  factory FeedbackEntity.empty() =>
      FeedbackEntity(id: -1, name: "", createdAt: "", choice: "", formCategories: []);

  factory FeedbackEntity.fromJson(Map<String, dynamic> json) => FeedbackEntity(
    id: json["id"] ?? -1,
    name: json["name"] ?? "",
    formCategories: json["form_categories"] == null
        ? []
        : List<FormCategory>.from(
        json["form_categories"]!.map((x) => FormCategory.fromJson(x))),
    createdAt: json["created_at"] ?? "",
    choice: json["choice"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "form_categories": formCategories == null
        ? []
        : List<dynamic>.from(formCategories!.map((x) => x.toJson())),
    "created_at": createdAt,
    "choice": choice,
  };
}
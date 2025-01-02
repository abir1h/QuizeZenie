import 'feedback.dart';
import 'form_category_type.dart';

class FormCategory {
  int id;
  FeedbackEntity category;
  List<FormCategoryType> formCategoryTypes;

  FormCategory({
    required this.id,
    required this.category,
    required this.formCategoryTypes,
  });
  factory FormCategory.empty() =>
      FormCategory(id: -1, category: FeedbackEntity.empty(), formCategoryTypes: []);

  factory FormCategory.fromJson(Map<String, dynamic> json) => FormCategory(
    id: json["id"],
    category: FeedbackEntity.fromJson(json["category"]),
    formCategoryTypes: List<FormCategoryType>.from(
        json["form_category_types"]
            .map((x) => FormCategoryType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category.toJson(),
    "form_category_types":
    List<dynamic>.from(formCategoryTypes.map((x) => x.toJson())),
  };
}
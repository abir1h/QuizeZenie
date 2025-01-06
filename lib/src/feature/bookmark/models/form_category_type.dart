import 'feedback.dart';

class FormCategoryType {
  int id;
  FeedbackEntity type;

  FormCategoryType({
    required this.id,
    required this.type,
  });
  factory FormCategoryType.empty() =>
      FormCategoryType(id: -1, type: FeedbackEntity.empty());

  factory FormCategoryType.fromJson(Map<String, dynamic> json) =>
      FormCategoryType(
        id: json["id"] ?? -1,
        type: json["type"] != null
            ? FeedbackEntity.fromJson(json["type"])
            : FeedbackEntity.empty(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type.toJson(),
  };
}
class CategoryModel {
  int id;
  String name;

  CategoryModel({required this.id, required this.name});

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

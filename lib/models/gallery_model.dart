class GalleryModel {
  int id;
  String url;

  GalleryModel({required this.id, required this.url});

  GalleryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        url = json['url'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}

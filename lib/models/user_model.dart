class UserModel {
  int id;
  String name;
  String email;
  String username;
  String? photoUrl;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.photoUrl,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        email = json['email'] ?? '',
        username = json['username'] ?? '',
        photoUrl = json['profile_photo_url'],
        token = json['token'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': photoUrl,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, username: $username, photoUrl: $photoUrl, token: $token}';
  }
}

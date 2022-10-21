class SocialUserModel {
  SocialUserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.image,
    required this.bio,
    required this.cover,

  });

  late final String uId;
  late final String username;
  late final String email;
  late final String image;
  late final String bio;
  late final String cover;


  SocialUserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    bio = json['bio'] ?? '';
    cover = json['cover'] ?? '';


  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'image': image,
      'bio': bio,
      'cover': cover,

    };
  }
}
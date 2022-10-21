class PostModel
{
  late final String name;
  late final String uId;
  late final String image;
  late final String dateTime;
  late final String text;
  late final String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}
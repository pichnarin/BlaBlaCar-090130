import '../model/post.dart';

class PostDTO {
  final int id;
  final String title;
  final String body;
  final String description;

  PostDTO({required this.id, required this.title, required this.body, required this.description});

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      description: 'description',
    );
  }

  Post toPost() {
    return Post(
      id: id,
      title: title,
      body: body,
      description: description,
    );
  }
}
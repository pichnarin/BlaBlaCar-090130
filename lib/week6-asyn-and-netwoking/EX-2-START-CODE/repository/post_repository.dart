import 'dart:convert';
import 'package:http/http.dart' as http;
import '../DTO/post_dto.dart';
import '../model/post.dart';


abstract class PostRepository {
  Future<List<Post>> fetchPosts();
}

class PostRepoImpl extends PostRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<PostDTO> postDTOs = body.map((dynamic item) => PostDTO.fromJson(item)).toList();
      List<Post> posts = postDTOs.map((postDTO) => postDTO.toPost()).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
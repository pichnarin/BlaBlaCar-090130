import '../model/post.dart';

import 'post_repository.dart';

class PostMockRepo extends PostRepository {
  final List<Post> _posts = [
    Post(id: 1, title: 'Who is the best teacher?', body: 'Teacher ronan', description: 'description'),
    Post(id: 2, title: 'Mock Post 2', body: 'This is another mock post body', description: 'description'),
  ];

  @override
  Future<List<Post>> fetchPosts() async {
    return Future.delayed(Duration(seconds: 1), () => _posts);
  }
}
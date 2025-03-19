import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';
import '../../model/post.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Center(
        child: postProvider.postsValue?.state == AsyncValueState.loading
            ? const CircularProgressIndicator()
            : postProvider.postsValue?.state == AsyncValueState.error
            ? Text('Error: ${postProvider.postsValue?.error}')
            : ListView.builder(
          itemCount: postProvider.postsValue?.data?.length ?? 0,
          itemBuilder: (context, index) {
            Post post = postProvider.postsValue!.data![index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => postProvider.fetchPosts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
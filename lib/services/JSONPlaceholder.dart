import 'dart:convert';

import 'package:userpostsapp/models/comment.dart';
import 'package:userpostsapp/models/post.dart';
import 'package:http/http.dart' as http;

class JSONPlaceholderService {
  Future<List<PostComment>> getPostComments(int postId) async {
    final response = await http.get("https://jsonplaceholder.typicode.com/comments?postId=$postId");

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => new PostComment.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<List<Post>> getUserPosts() async {
    final response = await http.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => new Post.fromJson(data))
          .toList();

    } else {
      throw Exception('Failed to load posts');
    }
  }

}
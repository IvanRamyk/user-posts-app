import 'package:flutter/material.dart';
import 'package:userpostsapp/models/post.dart';
import 'package:userpostsapp/screens/post_comments.dart';
import 'package:userpostsapp/services/JSONPlaceholder.dart';


class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Post> _posts = List();
  var _isLoading = false;

  _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    _posts = await JSONPlaceholderService().getUserPosts();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildPostItem(BuildContext context, int index) {
    final post = _posts[index];
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.body),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostCommentsScreen(post: post),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
    return ListView.builder(
        itemCount: _posts.length,
        itemBuilder: _buildPostItem
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Recent posts"),
        ),

        body: _buildBody(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }
}
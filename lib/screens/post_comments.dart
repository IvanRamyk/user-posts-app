import 'package:flutter/material.dart';
import 'package:userpostsapp/models/comment.dart';
import 'package:userpostsapp/models/post.dart';
import 'package:userpostsapp/services/JSONPlaceholder.dart';


class PostCommentsScreen extends StatefulWidget {
  final Post post;

  PostCommentsScreen({Key key, @required this.post}) : super(key: key);

  @override
  _PostCommentsScreenState createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  List<PostComment> _comments = List();
  var _isLoading = false;

  _fetchComments() async {
    setState(() {
      _isLoading = true;
    });
    _comments = await JSONPlaceholderService().getPostComments(widget.post.id);
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildCommentItem(BuildContext context, int index) {
    final post = _comments[index];
    return ListTile(
      title: Text(post.name),
      subtitle: Text(post.body),
    );
  }

  Widget _buildPostDivider(BuildContext context, int index) {
    return Divider(
      height: 1,
      color: Colors.black.withOpacity(0.12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Comments"),
        ),
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.separated(
          itemCount: _comments.length,
          itemBuilder: _buildCommentItem,
          separatorBuilder: _buildPostDivider,
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }
}
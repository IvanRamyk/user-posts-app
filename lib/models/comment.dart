class PostComment {
  int id;
  int postId;
  String name;
  String email;
  String body;

  PostComment({this.id, this.postId, this.name, this.email, this.body});

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return new PostComment(
      id: json['id'],
      postId: json['postId'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
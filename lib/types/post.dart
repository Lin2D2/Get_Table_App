class Post {
  final String state;

  Post({this.state});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      state: json['state'],
    );
  }
}
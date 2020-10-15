class Post {
  final String state;

  Post({this.state});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      state: json['state'],
    );
  }
}

class UserPost {
  final String state;
  final Map timetable;

  UserPost({this.state, this.timetable});

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      state: json['state'],
      timetable: json["timetable"],
    );
  }
}
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
  final String year;
  final Map timetable;

  UserPost({this.state, this.timetable, this.year});

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      state: json['state'],
      timetable: json["timetable"],
      year: json["year"]
    );
  }
}
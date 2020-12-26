class Teachers {
  final List teachers;

  Teachers({this.teachers});

  factory Teachers.fromJson(Map<String, dynamic> json) {
    return Teachers(teachers: json['teachers']);
  }
}

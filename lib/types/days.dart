class Days {
  final List days;

  Days({this.days});

  factory Days.fromJson(Map<String, dynamic> json) {
    return Days(
      days: json['days'],
    );
  }
}

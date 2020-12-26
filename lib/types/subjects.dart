class Subjects {
  final List subjectsShort;
  final List subjectsLong;

  Subjects({this.subjectsShort, this.subjectsLong});

  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(
      subjectsShort: json['subjects_short'],
      subjectsLong: json['subjects'],
    );
  }
}

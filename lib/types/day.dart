class Day {
  final Map day;

  Day({this.day});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      day: json['day'],
    );
  }
}
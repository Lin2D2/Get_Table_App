int getdayOfWeek (bool today) {
  DateTime date = DateTime.now();
  int dayOfWeek =
  today ? date.weekday : date.weekday + 1;
  if (dayOfWeek == 6 && today) {
    dayOfWeek = 1;
  }
  if (dayOfWeek == 6 && !today) {
    dayOfWeek = 1;
  }
  if (dayOfWeek == 7 && today) {
    dayOfWeek = 1;
  }
  if (dayOfWeek == 7 && !today) {
    dayOfWeek = 2;
  }
  if (dayOfWeek == 1 && !today) {
    dayOfWeek = 2;
  }
  return dayOfWeek;
}
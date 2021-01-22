int getdayOfWeek({bool today, String weekDay}) {
  DateTime date = DateTime.now();
  Map weekDays = {
    "montag": 1,
    "dienstag": 2,
    "mittwoch": 3,
    "donnerstag": 4,
    "freitag": 5,
  };
  if (today != null) {
    int dayOfWeek = today ? date.weekday : date.weekday + 1;
    if (dayOfWeek == 6 && today) {
      dayOfWeek = 1;
    }
    if (dayOfWeek == 6 && !today) {
      dayOfWeek = 2;
    }
    if (dayOfWeek == 7 && today) {
      dayOfWeek = 1;
    }
    if (dayOfWeek == 7 && !today) {
      dayOfWeek = 2;
    }
    if (dayOfWeek == 8 && !today) {
      dayOfWeek = 2;
    }
    return dayOfWeek;
  } else if (weekDay != null) {
    return weekDays[
        weekDay.toLowerCase().replaceAll(" ", "").replaceAll(",", "")];
  } else {
    return 0;
  }
}

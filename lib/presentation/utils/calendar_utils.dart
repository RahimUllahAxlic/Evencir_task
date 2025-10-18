class WeekMeta {
  final int index; // 1-based within the month
  final int total; // total weeks in the month
  final DateTime start; // Monday of that week
  final DateTime end; // Sunday of that week
  const WeekMeta({
    required this.index,
    required this.total,
    required this.start,
    required this.end,
  });
}

class CalendarUtils {
  // Monday-start helper
  static DateTime startOfWeek(DateTime d, {int firstDay = DateTime.monday}) {
    final date = DateTime(d.year, d.month, d.day);
    final diff = (date.weekday - firstDay) < 0
        ? (date.weekday - firstDay) + 7
        : (date.weekday - firstDay);
    return date.subtract(Duration(days: diff));
  }

  static DateTime endOfWeek(DateTime d, {int firstDay = DateTime.monday}) {
    return startOfWeek(d, firstDay: firstDay).add(const Duration(days: 6));
  }

  static List<DateTime> weekDates(DateTime date,
      {int firstDay = DateTime.monday}) {
    final start = startOfWeek(date, firstDay: firstDay);
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  static WeekMeta weekMetaOf(DateTime date, {int firstDay = DateTime.monday}) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final firstWeekStart = startOfWeek(firstDayOfMonth, firstDay: firstDay);
    final lastWeekStart = startOfWeek(lastDayOfMonth, firstDay: firstDay);
    final currentWeekStart = startOfWeek(date, firstDay: firstDay);

    final total = (lastWeekStart.difference(firstWeekStart).inDays ~/ 7) + 1;
    final index = (currentWeekStart.difference(firstWeekStart).inDays ~/ 7) + 1;

    return WeekMeta(
      index: index,
      total: total,
      start: currentWeekStart,
      end: currentWeekStart.add(const Duration(days: 6)),
    );
  }

  static bool isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

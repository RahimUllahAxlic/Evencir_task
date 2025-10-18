import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var currentWeek = 1.obs;
  var totalWeeks = 4.obs;
  var weekDates = <DateTime>[].obs;
  var workoutsMap = <DateTime, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    updateWeekData(selectedDate.value);
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    updateWeekData(date);
  }

  void updateWeekData(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final totalDays = DateTime(date.year, date.month + 1, 0).day;

    // Total weeks in month (ceil)
    totalWeeks.value = (totalDays / 7).ceil();

    // Determine which week the selected day belongs to
    currentWeek.value = ((date.day - 1) / 7).floor() + 1;

    // Build week dates (startDay → endDay)
    final startDay = (currentWeek.value - 1) * 7 + 1;
    final endDay = (startDay + 6 > totalDays) ? totalDays : startDay + 6;

    weekDates.value = [
      for (int d = startDay; d <= endDay; d++)
        DateTime(date.year, date.month, d),
    ];

    // Update selectedDate (so WeekSelector refreshes)
    selectedDate.value = date;
  }

  void assignWorkoutToDate(DateTime date, String workout) {
    workoutsMap[date] = workout;
  }
}

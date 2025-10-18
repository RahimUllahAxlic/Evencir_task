// lib/controllers/training_calendar/training_calendar_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/workout_model.dart';

class CalendarController extends GetxController {
  var workoutsMap = <DateTime, Workout>{}.obs;

  // List of workouts available to be dragged
  late List<Workout> availableWorkouts;

  // The dates for the current week being displayed
  var weekDates = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeWorkouts();
    _setupCurrentWeek();
  }

  void _initializeWorkouts() {
    // Define the available workouts that can be dragged
    availableWorkouts = [
      Workout(
        id: 'arm_blaster',
        title: 'Arm Blaster',
        category: 'Arms Workout',
        duration: '25m - 30m',
        tagColor: Colors.green.shade300,
      ),
      Workout(
        id: 'leg_day_blitz',
        title: 'Leg Day Blitz',
        category: 'A Leg Workout',
        duration: '25m - 30m',
        tagColor: Colors.blue.shade300,
      ),
      Workout(
        id: 'core_crusher',
        title: 'Core Crusher',
        category: 'Abs Workout',
        duration: '15m - 20m',
        tagColor: Colors.orange.shade300,
      ),
    ];
  }

  void _setupCurrentWeek() {
    // For demonstration, we'll create a static week that matches the screenshot (e.g., a Monday the 8th)
    // In a real app, you would calculate this based on the current date.
    final today = DateTime.now();
    // Find the last Monday
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    // Set the day to 8 to match the screenshot
    startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, 8);

    weekDates.value =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    // Pre-populate the map to match the initial state in the image
    final armBlaster = availableWorkouts[0];
    final legDayBlitz = availableWorkouts[1];

    // Monday is the first day (index 0), Thursday is the fourth day (index 3)
    workoutsMap[weekDates[0]] = armBlaster; // Mon 8
    workoutsMap[weekDates[3]] = legDayBlitz; // Thu 11
  }

  // Method to assign a workout to a specific date
  void assignWorkoutToDate(DateTime date, Workout workout) {
    // To allow moving an existing workout, first find and remove its old entry
    workoutsMap.removeWhere((key, value) => value.id == workout.id);
    // Assign the workout to the new date
    workoutsMap[date] = workout;
  }

  // Helper to format the weekday
  String getWeekday(DateTime date) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[date.weekday - 1];
  }
}

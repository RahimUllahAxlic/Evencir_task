import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_app/config/theme/app_colors.dart';
import 'package:task_app/presentation/controllers/home/home_controller.dart';
import '../../widgets/calendar/calendar_widget.dart';
import '../../widgets/calendar/week_selector.dart';
import '../../widgets/home/hydration_card.dart';
import '../../widgets/home/insight_card.dart';
import '../../widgets/home/workout_card.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  String getGreetingDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Obx(() {
            final now = DateTime.now();
            final isNight = now.hour >= 18 || now.hour < 6;
            final selectedDate = controller.selectedDate.value;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Notification Icon
                      Image.asset(
                        'assets/icons/notification.png',
                        width: 24,
                        height: 24,
                      ),

                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.black,
                            builder: (context) => CalendarBottomSheet(
                              initialSelected: controller.selectedDate.value,
                              onSelect: (selectedDate) {
                                controller.updateSelectedDate(selectedDate);
                              },
                            ),
                          );
                        },
                        child: Obx(() => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: AppColors.textColor,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Week ${controller.currentWeek.value}/${controller.totalWeeks.value}',
                                    style: GoogleFonts.mulish(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.textColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                            )),
                      ),

                      Container(),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Today, ${getGreetingDate(selectedDate)}",
                    style: GoogleFonts.mulish(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  WeekSelector(
                    selectedDate: selectedDate,
                    onDateSelected: (date) =>
                        controller.updateSelectedDate(date),
                  ),
                  const SizedBox(height: 32),

                  // Workouts Label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Workouts",
                        style: GoogleFonts.mulish(
                          color: AppColors.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        isNight
                            ? Icons.nightlight_round
                            : Icons.wb_sunny_outlined,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Workout Card
                  WorkoutCard(
                    title: "Upper Body",
                    time: "December 22 - 25m - 30m",
                    duration: "Full body strength",
                    onTap: () {
                      // Navigate to workout details
                    },
                  ),
                  const SizedBox(height: 28),

                  // Insights Header
                  Text(
                    "My Insights",
                    style: GoogleFonts.mulish(
                      color: AppColors.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 26),

                  // Insight Cards Row
                  const Row(
                    children: [
                      InsightCard(
                        title: "Calories",
                        value: "550",
                        unit: "Calories",
                        subtitle: "1950 Remaining",
                        progress: 550 / 2500,
                      ),
                      SizedBox(width: 10),
                      InsightCard(
                        title: "Weight",
                        value: "75",
                        unit: "kg",
                        subtitle: "+1.6kg",
                        progress: 0.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Hydration Card
                  const HydrationCard(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

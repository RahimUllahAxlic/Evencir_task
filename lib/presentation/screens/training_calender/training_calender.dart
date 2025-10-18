import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/config/theme/app_colors.dart';

import '../../../models/workout_model.dart';
import '../../controllers/training_calendar/training_calender_controller.dart';
import 'build_date_list_item.dart';
import 'build_week_bottom.dart';
import 'build_week_header.dart';

class TrainingCalendar extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());

  TrainingCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Training Calendar",
          style: GoogleFonts.mulish(
              color: AppColors.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement save logic
            },
            child: Text("Save",
                style: GoogleFonts.mulish(
                    color: AppColors.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 3,
            color: const Color.fromRGBO(72, 85, 223, 1),
          ),
          const SizedBox(height: 16),
          buildWeekHeader(),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: controller.weekDates.length,
                itemBuilder: (context, index) {
                  final date = controller.weekDates[index];
                  final assignedWorkout = controller.workoutsMap[date];
                  return buildDateListItem(date, assignedWorkout, controller);
                },
              ),
            ),
          ),
          Container(
            height: 3,
            color: const Color.fromRGBO(24, 170, 153, 1),
          ),
          const SizedBox(height: 16),
          buildWeekBottom(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

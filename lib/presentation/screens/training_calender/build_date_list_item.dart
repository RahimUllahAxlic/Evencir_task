import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/theme/app_colors.dart';
import '../../../models/workout_model.dart';
import '../../controllers/training_calendar/training_calender_controller.dart';

Widget buildDateListItem(
    DateTime date, Workout? workout, CalendarController controller) {
  return DragTarget<Workout>(
    onAccept: (droppedWorkout) {
      controller.assignWorkoutToDate(date, droppedWorkout);
    },
    builder: (context, candidateData, rejectedData) {
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    Text(
                      controller.getWeekday(date),
                      style: GoogleFonts.mulish(
                          color: workout != null
                              ? Colors.white
                              : Color.fromRGBO(93, 96, 124, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${date.day}",
                      style: GoogleFonts.mulish(
                          color: workout != null
                              ? Colors.white
                              : Color.fromRGBO(93, 96, 124, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: workout != null
                    ? _buildAssignedWorkout(workout)
                    : _buildDropTargetArea(candidateData.isNotEmpty),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 60.0, top: 16, bottom: 16),
            child: Divider(color: Colors.white12, height: 1),
          ),
        ],
      );
    },
  );
}

Widget _buildAssignedWorkout(Workout workout) {
  return Draggable<Workout>(
    data: workout,
    feedback: Material(
      color: Colors.transparent,
      child: _buildWorkoutCard(workout),
    ),
    childWhenDragging: Opacity(
      opacity: 0.5,
      child: _buildWorkoutCard(workout),
    ),
    child: _buildWorkoutCard(workout),
  );
}

Widget _buildDropTargetArea(bool isHovered) {
  return Container(
    height: 70, // Match height of workout card
    decoration: BoxDecoration(
      color: isHovered
          ? Colors.grey.shade800.withOpacity(0.5)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      border: isHovered ? Border.all(color: Colors.white38, width: 1) : null,
    ),
    child: const Center(
      child: Text(
        "", // No text needed for an empty drop area
        style: TextStyle(color: Colors.white38),
      ),
    ),
  );
}

Widget _buildWorkoutCard(Workout workout) {
  return Container(
    width: 300,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2C),
      borderRadius: BorderRadius.circular(12),
      border: const Border(
        left: BorderSide(
          color: AppColors.textColor,
          width: 7,
        ),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.drag_indicator,
            color: Color.fromRGBO(122, 124, 144, 1), size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: workout.tagColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  workout.category,
                  style: GoogleFonts.mulish(
                      color: workout.tagColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    workout.title,
                    style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    workout.duration,
                    style: GoogleFonts.mulish(
                        color: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

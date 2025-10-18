import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_app/config/theme/app_colors.dart';

enum Mood { happy, content, calm, peaceful }

class MoodDef {
  final Mood mood;
  final String label;
  final String asset;
  final Color colors;
  final double start;
  final double end;

  const MoodDef({
    required this.mood,
    required this.label,
    required this.asset,
    required this.colors,
    required this.start,
    required this.end,
  });
}

class MoodController extends GetxController {
  final RxDouble angle = (-pi / 4).obs;

  // Current mood computed from angle
  final Rx<Mood> currentMood = Mood.calm.obs;

  // Ring sizing (can be tuned to your Figma)
  final double ringThickness = 22;
  late final List<MoodDef> segments = [
    const MoodDef(
      mood: Mood.calm,
      label: 'Calm',
      asset: 'assets/images/calm.png',
      colors: AppColors.ringGreen,
      start: -pi / 2,
      end: 0,
    ),
    const MoodDef(
      mood: Mood.content,
      label: 'Content',
      asset: 'assets/images/content.png',
      colors: AppColors.ringPurple,
      start: 0,
      end: pi / 2,
    ),
    const MoodDef(
      mood: Mood.peaceful,
      label: 'Peaceful',
      asset: 'assets/images/peaceful.png',
      colors: AppColors.ringPink,
      start: pi / 2,
      end: pi,
    ),
    const MoodDef(
      mood: Mood.happy,
      label: 'Happy',
      asset: 'assets/images/happy.png',
      colors: AppColors.ringOrange,
      start: -pi,
      end: -pi / 2,
    ),
  ];

  MoodDef get activeDef => _moodFromAngle(angle.value);

  @override
  void onInit() {
    super.onInit();
    currentMood.value = activeDef.mood;
  }

  void onDragUpdate(Offset localPos, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final vector = localPos - center;
    var a = atan2(vector.dy, vector.dx);
    angle.value = a;
    final def = _moodFromAngle(a);
    if (def.mood != currentMood.value) {
      currentMood.value = def.mood;
      HapticFeedback.selectionClick();
    }
  }

  void snapToActiveCenter() {
    final def = activeDef;
    final mid = _midAngle(def.start, def.end);
    angle.value = mid;
  }

  String get label => activeDef.label;
  String get assetPath => activeDef.asset;

  // Helpers
  MoodDef _moodFromAngle(double a) {
    // Normalize to [-pi, pi)
    if (a >= pi) a -= 2 * pi;
    if (a < -pi) a += 2 * pi;

    for (final s in segments) {
      if (_inRange(a, s.start, s.end)) return s;
    }
    // Edge case when exactly at pi -> map to calm
    return segments[2];
  }

  bool _inRange(double a, double start, double end) {
    // Works across wrap-around since we split peaceful at negative range
    if (start < end) {
      return a >= start && a < end;
    } else {
      // across -pi/π wrap (not used here, but safe)
      return a >= start || a < end;
    }
  }

  double _midAngle(double start, double end) {
    double s = start, e = end;
    if (s > e) e += 2 * pi;
    final mid = (s + e) / 2;
    return ((mid + pi) % (2 * pi)) - pi;
  }
}

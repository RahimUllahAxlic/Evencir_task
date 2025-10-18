import 'package:flutter/material.dart';

class Workout {
  final String id;
  final String title;
  final String category;
  final String duration;
  final Color tagColor;

  Workout({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.tagColor,
  });
}

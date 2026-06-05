import 'package:flutter/material.dart';
 
class RecommendationItem {
  const RecommendationItem({
    required this.icon,
    required this.iconColor,
    required this.category,
    required this.title,
    required this.description,
    required this.actionText,
    required this.actionColor,
  });
 
  final IconData icon;
  final Color iconColor;
  final String category;
  final String title;
  final String description;
  final String actionText;
  final Color actionColor;
}
class MiniRecommendationItem {
  const MiniRecommendationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.buttonColor,
    required this.buttonBgColor,
  });
 
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color buttonColor;
  final Color buttonBgColor;
}
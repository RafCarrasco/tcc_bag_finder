import 'package:flutter/material.dart';

class FilterOption {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;

  FilterOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });
}

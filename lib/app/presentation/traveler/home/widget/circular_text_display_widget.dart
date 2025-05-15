import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CircularTextDisplay extends StatelessWidget {
  final String airportCode;

  const CircularTextDisplay({
    super.key,
    required this.airportCode,
  });

  String _getEssentialLetters(String input) {
    if (input.isNotEmpty) {
      return input.length <= 3
          ? input.toUpperCase()
          : input.substring(0, 2).toUpperCase();
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _getEssentialLetters(airportCode);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(
          0.6,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          displayText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

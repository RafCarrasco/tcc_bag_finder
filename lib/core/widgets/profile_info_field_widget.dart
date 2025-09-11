import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class InfoField extends StatelessWidget {
  final String title;
  final String content;

  const InfoField({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.secondaryGrey,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryBlack,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        Divider(
          indent: 0,
          color: AppColors.secondaryGrey,
          thickness: 1,
        ),
      ],
    );
  }
}

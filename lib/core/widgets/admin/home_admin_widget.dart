import 'package:flutter/material.dart';

class HomeAdminWidget extends StatelessWidget {
  final String company;
  const HomeAdminWidget({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.apartment_sharp,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Text(
          company,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      ],
    );
  }
}

import 'package:flutter/widgets.dart';

class ScreenHelper {
  final BuildContext context;

  ScreenHelper(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;

  double get screenHeight => MediaQuery.of(context).size.height;

  bool get isPortrait =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  double widthPercentage(double percentage) {
    return screenWidth * (percentage / 100);
  }

  double heightPercentage(double percentage) {
    return screenHeight * (percentage / 100);
  }
}

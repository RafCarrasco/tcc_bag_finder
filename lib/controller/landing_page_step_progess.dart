import 'package:flutter/material.dart';

class LandingPageStepProgess with ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

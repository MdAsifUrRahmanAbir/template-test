import 'package:flutter/material.dart';
import 'package:template_test/core/constants/app_colors.dart';
import 'package:template_test/core/constants/app_sizes.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<NavigationDestination> destinations;
  final bool showLabels;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.destinations,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.bottomNavBarHeight,
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelected,
        destinations: destinations,
        labelBehavior: showLabels
            ? NavigationDestinationLabelBehavior.alwaysShow
            : NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryLight,
      ),
    );
  }
}

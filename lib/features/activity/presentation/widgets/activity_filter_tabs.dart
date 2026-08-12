import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/segmented_tab_bar.dart';

/// Today / This Week / This Month filter for the activity feed.
/// Purely presentational — reports the selected index up to the
/// caller via [onChanged].
class ActivityFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ActivityFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedTabBar(
      labels: const [
        AppStrings.filterToday,
        AppStrings.filterThisWeek,
        AppStrings.filterThisMonth,
      ],
      selectedIndex: selectedIndex,
      onChanged: onChanged,
    );
  }
}
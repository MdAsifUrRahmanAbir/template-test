import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/main_shell_controller.dart';
import '../widgets/shell_tab_body.dart';
import '../widgets/shell_navigation_item.dart';

/// Wider-viewport layout — a side [NavigationRail] instead of a
/// bottom bar, built from the same [shellNavItems] list so mobile and
/// tablet always stay in sync when a tab is added or reordered.
class MainShellTabView extends ConsumerWidget {
  const MainShellTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(mainShellControllerProvider);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => ref.read(mainShellControllerProvider.notifier).selectTab(index),
            backgroundColor: AppColors.surface,
            labelType: NavigationRailLabelType.all,
            indicatorColor: Colors.transparent,
            selectedIconTheme: const IconThemeData(color: AppColors.primary),
            unselectedIconTheme: const IconThemeData(color: AppColors.textSecondary),
            selectedLabelTextStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
            unselectedLabelTextStyle: const TextStyle(color: AppColors.textSecondary),
            destinations: [
              for (final item in shellNavItems)
                NavigationRailDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: Text(item.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1, color: AppColors.border),
          Expanded(child: ShellTabBody(selectedIndex: selectedIndex)),
        ],
      ),
    );
  }
}
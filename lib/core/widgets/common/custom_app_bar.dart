import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// App-wide AppBar with consistent height, colors, and centered title —
/// used as a plain widget at the top of a screen's body (not necessarily
/// Scaffold.appBar), so it also works inside a Responsive mobile/tablet
/// view that doesn't own the Scaffold itself.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final Widget? leading;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.leading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: AppSizes.fontLg, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      ),
      backgroundColor: backgroundColor ?? AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: showBack,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}

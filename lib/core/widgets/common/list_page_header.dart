import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// Top header for list-style screens — a bold left-aligned title and
/// an optional trailing icon action, on a bordered white bar.
/// Distinct from [CustomAppBar]: no back button, no centered title —
/// used for top-level tab screens like Activity, Orders, Notifications.
class ListPageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  const ListPageHeader({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (actionIcon != null)
            InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              onTap: onActionTap,
              child: Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(actionIcon, size: AppSizes.iconSm, color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}
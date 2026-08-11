import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// Top bar with a plain back chevron, a bold left-aligned title, and
/// a trailing text-link action (e.g. "Done", "Cancel"). Distinct from
/// [CustomAppBar]: no bordered-square back button, no centered title —
/// used for modal/edit-style screens like Edit Profile.
class TextActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onBackTap;
  final VoidCallback? onActionTap;

  const TextActionAppBar({
    super.key,
    required this.title,
    required this.actionLabel,
    this.onBackTap,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
                child: const Padding(
                  padding: EdgeInsets.all(AppSizes.xs),
                  child: Icon(Icons.arrow_back_ios_new_rounded, size: AppSizes.iconSm, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(width: AppSizes.xs),
              Text(
                title,
                style: const TextStyle(
                  fontSize: AppSizes.fontXl,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            onTap: onActionTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.xs),
              child: Text(
                actionLabel,
                style: const TextStyle(
                  fontSize: AppSizes.fontLg,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}
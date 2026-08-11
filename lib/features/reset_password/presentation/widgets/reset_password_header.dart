import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/custom_icon_badge.dart';

/// Key/lock icon badge + "Create New Password" heading + subtitle at
/// the top of the reset-password screen. No CustomAppBar by design.
class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomIconBadge(
          icon: Icons.lock_reset_rounded,
          variant: IconBadgeVariant.filled,
        ),
        SizedBox(height: AppSizes.xl),
        Text(
          AppStrings.resetPasswordTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.fontDisplay,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.sm),
        Text(
          AppStrings.resetPasswordSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
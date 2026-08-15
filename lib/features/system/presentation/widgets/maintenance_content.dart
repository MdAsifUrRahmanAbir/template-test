import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/app_svg_icon.dart';
import '../../../../core/widgets/common/status_badge.dart';
import '../../../../core/widgets/common/secondary_button.dart';

/// Toolbox icon mark, title/subtitle, an ETA pill, and a "Notify Me
/// When Ready" outlined action. Purely presentational — the ETA
/// label and the notify action are supplied by the caller.
class MaintenanceContent extends StatelessWidget {
  final String etaLabel;
  final VoidCallback? onNotifyMe;

  const MaintenanceContent({
    super.key,
    required this.etaLabel,
    this.onNotifyMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSvgIcon(
          assetPath: AppAssets.maintenanceSVG,
          color: AppColors.primary,
          size: AppSizes.xxl * 2 + AppSizes.xl,
        ),
        const SizedBox(height: AppSizes.xl),
        const Text(
          AppStrings.maintenanceTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: AppSizes.fontXxl, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSizes.sm + AppSizes.xs),
        const Text(
          AppStrings.maintenanceSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary, height: 1.5),
        ),
        const SizedBox(height: AppSizes.md),
        StatusBadge(text: etaLabel, type: StatusBadgeType.success),
        const SizedBox(height: AppSizes.xl),
        SecondaryButton(
          label: AppStrings.notifyMeWhenReady,
          onPressed: onNotifyMe,
        ),
      ],
    );
  }
}
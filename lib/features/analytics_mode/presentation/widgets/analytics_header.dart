import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Title + Export button row, plus the date-range pill beneath it.
class AnalyticsHeader extends StatelessWidget {
  final String dateRangeLabel;
  final VoidCallback? onExportTap;
  final VoidCallback? onDateRangeTap;

  const AnalyticsHeader({
    super.key,
    required this.dateRangeLabel,
    this.onExportTap,
    this.onDateRangeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.analyticsTitle,
                style: TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              OutlinedButton.icon(
                onPressed: onExportTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm + AppSizes.xs, vertical: AppSizes.xs),
                ),
                icon: const Icon(Icons.expand_more_rounded, size: AppSizes.iconSm),
                label: const Text(AppStrings.exportLabel, style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm + AppSizes.xs),
          InkWell(
            onTap: onDateRangeTap,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm + AppSizes.xs, vertical: AppSizes.sm),
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today_outlined, size: AppSizes.iconSm, color: AppColors.textSecondary),
                  const SizedBox(width: AppSizes.sm),
                  Text(dateRangeLabel, style: const TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
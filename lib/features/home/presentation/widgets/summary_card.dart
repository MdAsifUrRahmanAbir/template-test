import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/common/status_badge.dart';
import '../../../../core/widgets/common/square_icon_tile.dart';

/// A single dashboard stat card — icon tile, trend badge, label, and
/// the big value. Used in a 2-column grid at the top of the home
/// screen.
class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String trendLabel;
  final bool isPositiveTrend;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.trendLabel,
    this.isPositiveTrend = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareIconTile(icon: icon, color: AppColors.primary),
              StatusBadge(
                text: trendLabel,
                type: isPositiveTrend ? StatusBadgeType.success : StatusBadgeType.error,
                compact: true,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            label,
            style: const TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppSizes.fontXxl,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
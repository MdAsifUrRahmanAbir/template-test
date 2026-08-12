import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import 'custom_card.dart';
import 'status_badge.dart';
import 'square_icon_tile.dart';

/// General-purpose stat card — label + big value, with an optional
/// icon and an optional trend badge. Omit [icon]/[trendLabel] for a
/// plain label/value card (was previously a separate `MiniStatCard`);
/// supply them for the full icon+trend variant (Home dashboard).
class SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final String? trendLabel;
  final bool isPositiveTrend;

  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.trendLabel,
    this.isPositiveTrend = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasHeader = icon != null || trendLabel != null;

    return CustomCard(
      padding: EdgeInsets.symmetric(
        vertical: hasHeader ? AppSizes.md : AppSizes.md,
        horizontal: hasHeader ? AppSizes.md : AppSizes.sm,
      ),
      child: Column(
        crossAxisAlignment: hasHeader ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (hasHeader) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (icon != null) SquareIconTile(icon: icon!, color: AppColors.primary),
                if (trendLabel != null)
                  StatusBadge(
                    text: trendLabel!,
                    type: isPositiveTrend ? StatusBadgeType.success : StatusBadgeType.error,
                    compact: true,
                  ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: hasHeader ? AppSizes.fontSm : AppSizes.fontXs,
              color: AppColors.textSecondary,
              letterSpacing: hasHeader ? null : 0.5,
            ),
          ),
          if (!hasHeader) const SizedBox(height: AppSizes.xs),
          Text(
            value,
            style: const TextStyle(fontSize: AppSizes.fontXxl, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
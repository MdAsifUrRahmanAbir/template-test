import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/custom_card.dart';

/// Compact stat card — small uppercase label on top, large bold
/// value below. Simpler than [SummaryCard] (no icon, no trend badge);
/// used wherever a plain label/value pair needs a bordered card, e.g.
/// a 3-up stats row on a profile screen.
class MiniStatCard extends StatelessWidget {
  final String label;
  final String value;

  const MiniStatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.md, horizontal: AppSizes.sm),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: AppSizes.fontXs, color: AppColors.textSecondary, letterSpacing: 0.5),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            value,
            style: const TextStyle(fontSize: AppSizes.fontXxl, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
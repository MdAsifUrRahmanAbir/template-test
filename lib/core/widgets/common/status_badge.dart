import 'package:flutter/material.dart';
import 'package:template_test/core/constants/app_colors.dart';
import 'package:template_test/core/constants/app_sizes.dart';

enum StatusBadgeType { success, warning, error, info, neutral, primary }

class StatusBadge extends StatelessWidget {
  final String text;
  final StatusBadgeType type;
  final IconData? icon;
  final bool compact;

  const StatusBadge({
    super.key,
    required this.text,
    this.type = StatusBadgeType.neutral,
    this.icon,
    this.compact = false,
  });

  Color get _color {
    switch (type) {
      case StatusBadgeType.success:
        return AppColors.success;
      case StatusBadgeType.warning:
        return AppColors.warning;
      case StatusBadgeType.error:
        return AppColors.error;
      case StatusBadgeType.info:
        return AppColors.info;
      case StatusBadgeType.primary:
        return AppColors.primary;
      case StatusBadgeType.neutral:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSizes.sm : AppSizes.md,
        vertical: AppSizes.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppSizes.iconSm, color: color),
            const SizedBox(width: AppSizes.xs),
          ],
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: AppSizes.fontSm,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

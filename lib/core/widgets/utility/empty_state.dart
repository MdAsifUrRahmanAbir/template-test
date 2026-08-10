import 'package:flutter/material.dart';
import 'package:template_test/core/constants/app_colors.dart';
import 'package:template_test/core/constants/app_sizes.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSizes.iconLg * 2, color: AppColors.textHint),
            const SizedBox(height: AppSizes.lg),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            if (message != null) ...[
              const SizedBox(height: AppSizes.sm),
              Text(message!, textAlign: TextAlign.center, style: const TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary)),
            ],
            if (onAction != null) ...[
              const SizedBox(height: AppSizes.lg),
              FilledButton(onPressed: onAction, child: Text(actionLabel ?? 'Try again')),
            ],
          ],
        ),
      ),
    );
  }
}

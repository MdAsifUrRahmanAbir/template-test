import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Single settings row — leading icon, title + subtitle, trailing
/// chevron. Undecorated on its own (no border/radius); meant to be
/// placed inside a [SettingsGroup].
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm + AppSizes.xs),
        child: Row(
          children: [
            Icon(icon, size: AppSizes.iconMd - AppSizes.xs / 2, color: AppColors.textSecondary),
            const SizedBox(width: AppSizes.sm + AppSizes.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: AppSizes.xs / 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: AppSizes.iconSm, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
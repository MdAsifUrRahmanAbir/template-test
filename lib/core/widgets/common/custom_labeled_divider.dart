import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// Horizontal divider with a centered label — "or continue with",
/// "or sign up with", etc.
class CustomLabeledDivider extends StatelessWidget {
  final String label;

  const CustomLabeledDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
          child: Text(
            label,
            style: const TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
      ],
    );
  }
}

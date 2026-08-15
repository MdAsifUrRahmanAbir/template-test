import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// App name + tagline shown below the [SplashLogo].
class SplashBrandText extends StatelessWidget {
  const SplashBrandText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          AppStrings.appName,
          style: TextStyle(fontSize: AppSizes.fontDisplay, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        SizedBox(height: AppSizes.xs),
        Text(
          AppStrings.appTagline,
          style: TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
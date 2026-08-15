import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/hero_image_banner.dart';

/// Hero illustration + title + subtitle shown on the welcome screen.
class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeroImageBanner(imagePath: 'assets/images/welcome_hero.png'),
        const SizedBox(height: AppSizes.xl),
        const Text(
          AppStrings.welcomeToApp,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: AppSizes.fontDisplay, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSizes.sm),
        const Text(
          AppStrings.welcomeToAppSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../data/models/onboarding_model.dart';

/// One onboarding slide — illustration + title + description inside the
/// shared [CustomCard] container. Used as the PageView's itemBuilder.
class OnboardingItemWidget extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                child: AspectRatio(
                  aspectRatio: 287 / 180,
                  child: Image.asset(
                    data.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.background,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_outlined, color: AppColors.textHint, size: AppSizes.iconLg),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
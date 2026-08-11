import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// "Create Your Account" heading shown at the top of the register card.
class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.createYourAccount,
      style: TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    );
  }
}
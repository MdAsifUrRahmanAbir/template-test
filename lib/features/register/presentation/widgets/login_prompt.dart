import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/link_button.dart';

/// "Already have an account? Login" row shown at the bottom of the
/// register screen.
class LoginPrompt extends StatelessWidget {
  final VoidCallback? onLoginTap;

  const LoginPrompt({super.key, this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary),
        ),
        LinkButton(
          label: AppStrings.login,
          fontSize: AppSizes.fontSm,
          onPressed: onLoginTap,
        ),
      ],
    );
  }
}
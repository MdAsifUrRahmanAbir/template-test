import 'package:flutter/material.dart';
import 'package:template_test/core/constants/app_colors.dart';
import 'package:template_test/core/constants/app_sizes.dart';

class CustomBottomSheet {
  CustomBottomSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
    bool useSafeArea = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXl)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:template_test/core/constants/app_colors.dart';
import 'package:template_test/core/constants/app_sizes.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final canPrevious = currentPage > 1;
    final canNext = currentPage < totalPages;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: canPrevious ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left),
          color: AppColors.primary,
          iconSize: AppSizes.iconMd,
        ),
        Text('$currentPage / $totalPages', style: const TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        IconButton(
          onPressed: canNext ? () => onPageChanged(currentPage + 1) : null,
          icon: const Icon(Icons.chevron_right),
          color: AppColors.primary,
          iconSize: AppSizes.iconMd,
        ),
      ],
    );
  }
}

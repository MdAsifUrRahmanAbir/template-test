import 'package:flutter/material.dart';
import 'package:template_test/core/constants/app_colors.dart';
import 'package:template_test/core/constants/app_sizes.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool enabled;

  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSizes.md),
    this.margin,
    this.color,
    this.borderRadius,
    this.border,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppSizes.radiusLg);
    final content = Padding(padding: padding, child: child);
    final decorated = Material(
      color: color ?? AppColors.surface,
      borderRadius: radius,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: radius,
        child: content,
      ),
    );
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: radius,
        border: border ?? const Border.fromBorderSide(BorderSide(color: AppColors.border)),
      ),
      child: decorated,
    );
  }
}

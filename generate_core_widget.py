from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path
from textwrap import dedent


APP_COLORS = {
    "primary": "AppColors.primary",
    "primaryDark": "AppColors.primaryDark",
    "primaryLight": "AppColors.primaryLight",
    "accent": "AppColors.accent",
    "accentLight": "AppColors.accentLight",
    "background": "AppColors.background",
    "surface": "AppColors.surface",
    "surfaceDark": "AppColors.surfaceDark",
    "textPrimary": "AppColors.textPrimary",
    "textSecondary": "AppColors.textSecondary",
    "textHint": "AppColors.textHint",
    "textWhite": "AppColors.textWhite",
    "success": "AppColors.success",
    "warning": "AppColors.warning",
    "error": "AppColors.error",
    "info": "AppColors.info",
    "border": "AppColors.border",
    "divider": "AppColors.divider",
    "shimmerBase": "AppColors.shimmerBase",
    "shimmerHighlight": "AppColors.shimmerHighlight",
}

APP_SIZES = {
    "xs": "AppSizes.xs",
    "sm": "AppSizes.sm",
    "md": "AppSizes.md",
    "lg": "AppSizes.lg",
    "xl": "AppSizes.xl",
    "xxl": "AppSizes.xxl",
    "radiusSm": "AppSizes.radiusSm",
    "radiusMd": "AppSizes.radiusMd",
    "radiusLg": "AppSizes.radiusLg",
    "radiusXl": "AppSizes.radiusXl",
    "radiusFull": "AppSizes.radiusFull",
    "iconSm": "AppSizes.iconSm",
    "iconMd": "AppSizes.iconMd",
    "iconLg": "AppSizes.iconLg",
    "fontXs": "AppSizes.fontXs",
    "fontSm": "AppSizes.fontSm",
    "fontMd": "AppSizes.fontMd",
    "fontLg": "AppSizes.fontLg",
    "fontXl": "AppSizes.fontXl",
    "fontXxl": "AppSizes.fontXxl",
    "fontDisplay": "AppSizes.fontDisplay",
    "buttonHeight": "AppSizes.buttonHeight",
    "inputHeight": "AppSizes.inputHeight",
    "appBarHeight": "AppSizes.appBarHeight",
    "bottomNavBarHeight": "AppSizes.bottomNavBarHeight",
}


def dart(source: str) -> str:
    return dedent(source).strip() + "\n"


COMMON_WIDGETS: dict[str, str] = {
    "primary_button.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class PrimaryButton extends StatelessWidget {
          final String label;
          final VoidCallback? onPressed;
          final bool loading;
          final bool expanded;
          final IconData? icon;
          final Widget? leading;
          final Widget? trailing;
          final double? width;
          final EdgeInsetsGeometry? padding;
          final BorderRadius? borderRadius;
          final ButtonStyle? style;

          const PrimaryButton({
            super.key,
            required this.label,
            this.onPressed,
            this.loading = false,
            this.expanded = true,
            this.icon,
            this.leading,
            this.trailing,
            this.width,
            this.padding,
            this.borderRadius,
            this.style,
          });

          @override
          Widget build(BuildContext context) {
            final content = AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: loading
                  ? const SizedBox(
                      key: ValueKey('loading'),
                      width: AppSizes.iconSm,
                      height: AppSizes.iconSm,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textWhite,
                      ),
                    )
                  : Row(
                      key: const ValueKey('content'),
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (leading != null) ...[leading!, const SizedBox(width: AppSizes.sm)],
                        if (icon != null) ...[
                          Icon(icon, size: AppSizes.iconMd),
                          const SizedBox(width: AppSizes.sm),
                        ],
                        Text(label),
                        if (trailing != null) ...[const SizedBox(width: AppSizes.sm), trailing!],
                      ],
                    ),
            );

            final button = SizedBox(
              width: width ?? (expanded ? double.infinity : null),
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: loading ? null : onPressed,
                style: style ?? ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textWhite,
                  disabledBackgroundColor: AppColors.primaryLight,
                  disabledForegroundColor: AppColors.textSecondary,
                  padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  elevation: 0,
                ),
                child: content,
              ),
            );

            return Semantics(button: true, enabled: !loading && onPressed != null, child: button);
          }
        }
    '''),
    "secondary_button.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class SecondaryButton extends StatelessWidget {
          final String label;
          final VoidCallback? onPressed;
          final IconData? icon;
          final bool expanded;
          final double? width;
          final ButtonStyle? style;

          const SecondaryButton({
            super.key,
            required this.label,
            this.onPressed,
            this.icon,
            this.expanded = true,
            this.width,
            this.style,
          });

          @override
          Widget build(BuildContext context) {
            final child = icon == null
                ? Text(label)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: AppSizes.iconMd),
                      const SizedBox(width: AppSizes.sm),
                      Text(label),
                    ],
                  );

            return SizedBox(
              width: width ?? (expanded ? double.infinity : null),
              height: AppSizes.buttonHeight,
              child: OutlinedButton(
                onPressed: onPressed,
                style: style ?? OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                child: child,
              ),
            );
          }
        }
    '''),
    "text_button.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class AppTextButton extends StatelessWidget {
          final String label;
          final VoidCallback? onPressed;
          final IconData? icon;
          final bool compact;

          const AppTextButton({
            super.key,
            required this.label,
            this.onPressed,
            this.icon,
            this.compact = false,
          });

          @override
          Widget build(BuildContext context) {
            final child = icon == null
                ? Text(label)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: AppSizes.iconSm),
                      const SizedBox(width: AppSizes.xs),
                      Text(label),
                    ],
                  );
            return TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: compact
                    ? const EdgeInsets.symmetric(horizontal: AppSizes.sm)
                    : const EdgeInsets.symmetric(horizontal: AppSizes.md),
              ),
              child: child,
            );
          }
        }
    '''),
    "icon_button.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class AppIconButton extends StatelessWidget {
          final IconData icon;
          final VoidCallback? onPressed;
          final String? tooltip;
          final Color? color;
          final Color? backgroundColor;
          final double? iconSize;
          final bool filled;

          const AppIconButton({
            super.key,
            required this.icon,
            this.onPressed,
            this.tooltip,
            this.color,
            this.backgroundColor,
            this.iconSize,
            this.filled = false,
          });

          @override
          Widget build(BuildContext context) {
            final button = IconButton(
              onPressed: onPressed,
              tooltip: tooltip,
              iconSize: iconSize ?? AppSizes.iconMd,
              color: color ?? AppColors.textPrimary,
              style: IconButton.styleFrom(
                backgroundColor: filled ? (backgroundColor ?? AppColors.primaryLight) : null,
                foregroundColor: color ?? AppColors.textPrimary,
                disabledForegroundColor: AppColors.textHint,
                padding: const EdgeInsets.all(AppSizes.sm),
              ),
              icon: Icon(icon),
            );
            return button;
          }
        }
    '''),
    "primary_input_field.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class PrimaryInputField extends StatelessWidget {
          final String? label;
          final String? hint;
          final String? helperText;
          final TextEditingController? controller;
          final FocusNode? focusNode;
          final String? Function(String?)? validator;
          final bool obscureText;
          final TextInputType? keyboardType;
          final TextInputAction? textInputAction;
          final Widget? prefixIcon;
          final Widget? suffixIcon;
          final int maxLines;
          final int? maxLength;
          final bool enabled;
          final bool readOnly;
          final ValueChanged<String>? onChanged;
          final VoidCallback? onTap;
          final TextCapitalization textCapitalization;

          const PrimaryInputField({
            super.key,
            this.label,
            this.hint,
            this.helperText,
            this.controller,
            this.focusNode,
            this.validator,
            this.obscureText = false,
            this.keyboardType,
            this.textInputAction,
            this.prefixIcon,
            this.suffixIcon,
            this.maxLines = 1,
            this.maxLength,
            this.enabled = true,
            this.readOnly = false,
            this.onChanged,
            this.onTap,
            this.textCapitalization = TextCapitalization.none,
          });

          @override
          Widget build(BuildContext context) {
            return ConstrainedBox(
              constraints: const BoxConstraints(minHeight: AppSizes.inputHeight),
              child: TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: validator,
                obscureText: obscureText,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                maxLines: obscureText ? 1 : maxLines,
                maxLength: maxLength,
                enabled: enabled,
                readOnly: readOnly,
                onChanged: onChanged,
                onTap: onTap,
                textCapitalization: textCapitalization,
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  helperText: helperText,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: AppSizes.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                ),
              ),
            );
          }
        }
    '''),
    "search_field.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';
        import 'package:__PACKAGE_NAME__/core/widgets/common/icon_button.dart';

        class SearchField extends StatelessWidget {
          final String hintText;
          final ValueChanged<String>? onChanged;
          final ValueChanged<String>? onSubmitted;
          final TextEditingController? controller;
          final FocusNode? focusNode;
          final VoidCallback? onClear;
          final bool autofocus;
          final bool enabled;

          const SearchField({
            super.key,
            this.hintText = 'Search',
            this.onChanged,
            this.onSubmitted,
            this.controller,
            this.focusNode,
            this.onClear,
            this.autofocus = false,
            this.enabled = true,
          });

          @override
          Widget build(BuildContext context) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              autofocus: autofocus,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.search, size: AppSizes.iconMd),
                suffixIcon: onClear == null
                    ? null
                    : AppIconButton(
                        icon: Icons.clear,
                        tooltip: 'Clear search',
                        onPressed: onClear,
                        iconSize: AppSizes.iconSm,
                      ),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            );
          }
        }
    '''),
    "dropdown_field.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class DropdownField<T> extends StatelessWidget {
          final T? value;
          final List<DropdownMenuItem<T>> items;
          final ValueChanged<T?>? onChanged;
          final String? label;
          final String? hint;
          final String? Function(T?)? validator;
          final bool enabled;

          const DropdownField({
            super.key,
            this.value,
            required this.items,
            this.onChanged,
            this.label,
            this.hint,
            this.validator,
            this.enabled = true,
          });

          @override
          Widget build(BuildContext context) {
            return DropdownButtonFormField<T>(
              initialValue: value,
              items: items,
              onChanged: enabled ? onChanged : null,
              validator: validator,
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            );
          }
        }
    '''),
    "date_field.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class DateField extends StatelessWidget {
          final String label;
          final String? hint;
          final DateTime? value;
          final DateTime? firstDate;
          final DateTime? lastDate;
          final ValueChanged<DateTime>? onChanged;
          final String Function(DateTime)? formatter;
          final String? Function(String?)? validator;
          final bool enabled;

          const DateField({
            super.key,
            this.label = 'Date',
            this.hint,
            this.value,
            this.firstDate,
            this.lastDate,
            this.onChanged,
            this.formatter,
            this.validator,
            this.enabled = true,
          });

          String _format(DateTime date) => formatter?.call(date) ?? '${date.day}/${date.month}/${date.year}';

          @override
          Widget build(BuildContext context) {
            return TextFormField(
              readOnly: true,
              enabled: enabled,
              validator: validator,
              controller: TextEditingController(text: value == null ? '' : _format(value!)),
              onTap: !enabled
                  ? null
                  : () async {
                      final selected = await showDatePicker(
                        context: context,
                        firstDate: firstDate ?? DateTime(2000),
                        lastDate: lastDate ?? DateTime(2100),
                        initialDate: value ?? DateTime.now(),
                        builder: (context, child) => Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: AppColors.primary,
                              surface: AppColors.surface,
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      if (selected != null) onChanged?.call(selected);
                    },
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                suffixIcon: const Icon(Icons.calendar_today_outlined, size: AppSizes.iconMd),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            );
          }
        }
    '''),
    "primary_checkbox.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class PrimaryCheckbox extends StatelessWidget {
          final bool value;
          final ValueChanged<bool?>? onChanged;
          final String? label;
          final Widget? secondary;
          final bool tristate;

          const PrimaryCheckbox({
            super.key,
            required this.value,
            this.onChanged,
            this.label,
            this.secondary,
            this.tristate = false,
          });

          @override
          Widget build(BuildContext context) {
            return CheckboxListTile(
              value: value,
              onChanged: onChanged,
              tristate: tristate,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
              activeColor: AppColors.primary,
              checkColor: AppColors.textWhite,
              title: label == null ? null : Text(label!),
              secondary: secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
            );
          }
        }
    '''),
    "primary_switch.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class PrimarySwitch extends StatelessWidget {
          final bool value;
          final ValueChanged<bool>? onChanged;
          final String? label;
          final String? subtitle;

          const PrimarySwitch({
            super.key,
            required this.value,
            this.onChanged,
            this.label,
            this.subtitle,
          });

          @override
          Widget build(BuildContext context) {
            return SwitchListTile(
              value: value,
              onChanged: onChanged,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
              activeColor: AppColors.primary,
              title: label == null ? null : Text(label!),
              subtitle: subtitle == null ? null : Text(subtitle!),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
            );
          }
        }
    '''),
    "radio_option.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class RadioOption<T> extends StatelessWidget {
          final T value;
          final T? groupValue;
          final ValueChanged<T?>? onChanged;
          final String title;
          final String? subtitle;

          const RadioOption({
            super.key,
            required this.value,
            required this.groupValue,
            required this.onChanged,
            required this.title,
            this.subtitle,
          });

          @override
          Widget build(BuildContext context) {
            return RadioListTile<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
              title: Text(title),
              subtitle: subtitle == null ? null : Text(subtitle!),
            );
          }
        }
    '''),
    "custom_app_bar.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
          final String title;
          final List<Widget>? actions;
          final Widget? leading;
          final bool showBack;
          final bool centerTitle;
          final Color? backgroundColor;
          final Widget? bottom;

          const CustomAppBar({
            super.key,
            required this.title,
            this.actions,
            this.leading,
            this.showBack = true,
            this.centerTitle = true,
            this.backgroundColor,
            this.bottom,
          });

          @override
          Widget build(BuildContext context) {
            return AppBar(
              title: Text(title),
              leading: leading,
              automaticallyImplyLeading: showBack && leading == null,
              centerTitle: centerTitle,
              actions: actions,
              bottom: bottom == null ? null : PreferredSize(preferredSize: const Size.fromHeight(AppSizes.xs), child: bottom!),
              backgroundColor: backgroundColor ?? AppColors.surface,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: AppSizes.appBarHeight,
            );
          }

          @override
          Size get preferredSize => Size.fromHeight(AppSizes.appBarHeight + (bottom == null ? 0 : AppSizes.xs));
        }
    '''),
    "custom_card.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

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
    '''),
    "custom_list_tile.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomListTile extends StatelessWidget {
          final String title;
          final String? subtitle;
          final Widget? leading;
          final Widget? trailing;
          final VoidCallback? onTap;
          final bool enabled;

          const CustomListTile({
            super.key,
            required this.title,
            this.subtitle,
            this.leading,
            this.trailing,
            this.onTap,
            this.enabled = true,
          });

          @override
          Widget build(BuildContext context) {
            return ListTile(
              enabled: enabled,
              title: Text(title),
              subtitle: subtitle == null ? null : Text(subtitle!),
              leading: leading,
              trailing: trailing,
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.xs),
              iconColor: AppColors.textSecondary,
              textColor: AppColors.textPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
            );
          }
        }
    '''),
    "status_badge.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        enum StatusBadgeType { success, warning, error, info, neutral, primary }

        class StatusBadge extends StatelessWidget {
          final String text;
          final StatusBadgeType type;
          final IconData? icon;
          final bool compact;

          const StatusBadge({
            super.key,
            required this.text,
            this.type = StatusBadgeType.neutral,
            this.icon,
            this.compact = false,
          });

          Color get _color {
            switch (type) {
              case StatusBadgeType.success:
                return AppColors.success;
              case StatusBadgeType.warning:
                return AppColors.warning;
              case StatusBadgeType.error:
                return AppColors.error;
              case StatusBadgeType.info:
                return AppColors.info;
              case StatusBadgeType.primary:
                return AppColors.primary;
              case StatusBadgeType.neutral:
                return AppColors.textSecondary;
            }
          }

          @override
          Widget build(BuildContext context) {
            final color = _color;
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? AppSizes.sm : AppSizes.md,
                vertical: AppSizes.xs,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                border: Border.all(color: color.withValues(alpha: 0.24)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppSizes.iconSm, color: color),
                    const SizedBox(width: AppSizes.xs),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color: color,
                      fontSize: AppSizes.fontSm,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }
        }
    '''),
    "section_header.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class SectionHeader extends StatelessWidget {
          final String title;
          final String? subtitle;
          final String? actionLabel;
          final VoidCallback? onAction;
          final Widget? trailing;

          const SectionHeader({
            super.key,
            required this.title,
            this.subtitle,
            this.actionLabel,
            this.onAction,
            this.trailing,
          });

          @override
          Widget build(BuildContext context) {
            final action = trailing ?? (actionLabel == null ? null : TextButton(onPressed: onAction, child: Text(actionLabel!)));
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: AppSizes.fontLg, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSizes.xs),
                        Text(subtitle!, style: const TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary)),
                      ],
                    ],
                  ),
                ),
                if (action != null) action,
              ],
            );
          }
        }
    '''),
    "custom_bottom_nav.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomBottomNav extends StatelessWidget {
          final int selectedIndex;
          final ValueChanged<int> onSelected;
          final List<NavigationDestination> destinations;
          final bool showLabels;

          const CustomBottomNav({
            super.key,
            required this.selectedIndex,
            required this.onSelected,
            required this.destinations,
            this.showLabels = true,
          });

          @override
          Widget build(BuildContext context) {
            return SizedBox(
              height: AppSizes.bottomNavBarHeight,
              child: NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: onSelected,
                destinations: destinations,
                labelBehavior: showLabels
                    ? NavigationDestinationLabelBehavior.alwaysShow
                    : NavigationDestinationLabelBehavior.onlyShowSelected,
                backgroundColor: AppColors.surface,
                indicatorColor: AppColors.primaryLight,
              ),
            );
          }
        }
    '''),
    "custom_tab_bar.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomTabBar extends StatelessWidget {
          final TabController? controller;
          final List<Widget> tabs;
          final bool isScrollable;

          const CustomTabBar({
            super.key,
            this.controller,
            required this.tabs,
            this.isScrollable = false,
          });

          @override
          Widget build(BuildContext context) {
            return TabBar(
              controller: controller,
              tabs: tabs,
              isScrollable: isScrollable,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: AppSizes.xs,
              labelStyle: const TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w600),
              tabAlignment: isScrollable ? TabAlignment.start : TabAlignment.fill,
            );
          }
        }
    '''),
    "avatar.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class AppAvatar extends StatelessWidget {
          final String? imageUrl;
          final String? label;
          final double radius;
          final VoidCallback? onTap;

          const AppAvatar({
            super.key,
            this.imageUrl,
            this.label,
            this.radius = AppSizes.xxl,
            this.onTap,
          });

          @override
          Widget build(BuildContext context) {
            final avatar = CircleAvatar(
              radius: radius,
              backgroundColor: AppColors.primaryLight,
              backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl!),
              child: imageUrl != null
                  ? null
                  : Text(
                      (label?.trim().isNotEmpty ?? false) ? label!.trim()[0].toUpperCase() : '?',
                      style: const TextStyle(color: AppColors.primary, fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700),
                    ),
            );
            return onTap == null ? avatar : GestureDetector(onTap: onTap, child: avatar);
          }
        }
    '''),
}

UTILITY_WIDGETS: dict[str, str] = {
    "custom_loader.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomLoader extends StatelessWidget {
          final double? size;
          final Color? color;
          final String? label;
          final bool overlay;

          const CustomLoader({super.key, this.size, this.color, this.label, this.overlay = false});

          @override
          Widget build(BuildContext context) {
            final loader = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size ?? AppSizes.iconLg,
                  height: size ?? AppSizes.iconLg,
                  child: CircularProgressIndicator(
                    strokeWidth: AppSizes.xs / 2,
                    color: color ?? AppColors.primary,
                  ),
                ),
                if (label != null) ...[
                  const SizedBox(height: AppSizes.md),
                  Text(label!, style: const TextStyle(color: AppColors.textSecondary, fontSize: AppSizes.fontSm)),
                ],
              ],
            );
            return overlay
                ? ColoredBox(color: AppColors.background.withValues(alpha: 0.72), child: Center(child: loader))
                : Center(child: loader);
          }
        }
    '''),
    "custom_shimmer.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomShimmer extends StatefulWidget {
          final double height;
          final double? width;
          final BorderRadius? borderRadius;

          const CustomShimmer({
            super.key,
            this.height = AppSizes.xxl,
            this.width,
            this.borderRadius,
          });

          @override
          State<CustomShimmer> createState() => _CustomShimmerState();
        }

        class _CustomShimmerState extends State<CustomShimmer> with SingleTickerProviderStateMixin {
          late final AnimationController _controller;

          @override
          void initState() {
            super.initState();
            _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat();
          }

          @override
          void dispose() {
            _controller.dispose();
            super.dispose();
          }

          @override
          Widget build(BuildContext context) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1 + (_controller.value * 2), 0),
                    end: Alignment(1 + (_controller.value * 2), 0),
                    colors: const [AppColors.shimmerBase, AppColors.shimmerHighlight, AppColors.shimmerBase],
                  ),
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: SizedBox(height: widget.height, width: widget.width ?? double.infinity),
              ),
            );
          }
        }
    '''),
    "empty_state.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class EmptyState extends StatelessWidget {
          final String title;
          final String? message;
          final String? actionLabel;
          final VoidCallback? onAction;
          final IconData icon;

          const EmptyState({
            super.key,
            required this.title,
            this.message,
            this.actionLabel,
            this.onAction,
            this.icon = Icons.inbox_outlined,
          });

          @override
          Widget build(BuildContext context) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: AppSizes.iconLg * 2, color: AppColors.textHint),
                    const SizedBox(height: AppSizes.lg),
                    Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    if (message != null) ...[
                      const SizedBox(height: AppSizes.sm),
                      Text(message!, textAlign: TextAlign.center, style: const TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary)),
                    ],
                    if (onAction != null) ...[
                      const SizedBox(height: AppSizes.lg),
                      FilledButton(onPressed: onAction, child: Text(actionLabel ?? 'Try again')),
                    ],
                  ],
                ),
              ),
            );
          }
        }
    '''),
    "error_state.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class ErrorState extends StatelessWidget {
          final String message;
          final VoidCallback? onRetry;
          final String retryLabel;

          const ErrorState({
            super.key,
            required this.message,
            this.onRetry,
            this.retryLabel = 'Retry',
          });

          @override
          Widget build(BuildContext context) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: AppSizes.iconLg * 2, color: AppColors.error),
                    const SizedBox(height: AppSizes.md),
                    Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: AppSizes.fontMd, color: AppColors.textSecondary)),
                    if (onRetry != null) ...[
                      const SizedBox(height: AppSizes.lg),
                      OutlinedButton(onPressed: onRetry, child: Text(retryLabel)),
                    ],
                  ],
                ),
              ),
            );
          }
        }
    '''),
    "custom_snackbar.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        enum SnackbarType { success, error, warning, info }

        class CustomSnackbar {
          CustomSnackbar._();

          static void show(
            BuildContext context,
            String message, {
            SnackbarType type = SnackbarType.info,
            String? actionLabel,
            VoidCallback? onAction,
          }) {
            final messenger = ScaffoldMessenger.of(context);
            messenger.hideCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(_icon(type), color: AppColors.textWhite, size: AppSizes.iconMd),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(child: Text(message)),
                  ],
                ),
                backgroundColor: _color(type),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(AppSizes.md),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                action: actionLabel == null ? null : SnackBarAction(label: actionLabel, onPressed: onAction ?? () {}),
              ),
            );
          }

          static Color _color(SnackbarType type) => switch (type) {
                SnackbarType.success => AppColors.success,
                SnackbarType.error => AppColors.error,
                SnackbarType.warning => AppColors.warning,
                SnackbarType.info => AppColors.info,
              };

          static IconData _icon(SnackbarType type) => switch (type) {
                SnackbarType.success => Icons.check_circle_outline,
                SnackbarType.error => Icons.error_outline,
                SnackbarType.warning => Icons.warning_amber_outlined,
                SnackbarType.info => Icons.info_outline,
              };
        }
    '''),
    "custom_dialog.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomDialog {
          CustomDialog._();

          static Future<T?> show<T>(
            BuildContext context, {
            required String title,
            required Widget child,
            List<Widget>? actions,
            bool barrierDismissible = true,
          }) {
            return showDialog<T>(
              context: context,
              barrierDismissible: barrierDismissible,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.surface,
                title: Text(title),
                content: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: AppSizes.xxl * 8),
                  child: child,
                ),
                actions: actions,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
              ),
            );
          }
        }
    '''),
    "custom_alert_dialog.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomAlertDialog {
          CustomAlertDialog._();

          static Future<bool?> confirm(
            BuildContext context, {
            required String title,
            required String message,
            String confirmText = 'Confirm',
            String cancelText = 'Cancel',
            bool destructive = false,
          }) {
            return showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.surface,
                title: Text(title),
                content: Text(message),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: Text(cancelText)),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: destructive ? AppColors.error : AppColors.primary),
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(confirmText),
                  ),
                ],
              ),
            );
          }
        }
    '''),
    "custom_bottom_sheet.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

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
    '''),
    "custom_filter_bar.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

        class CustomFilterBar<T> extends StatelessWidget {
          final List<T> filters;
          final Set<T> selectedFilters;
          final String Function(T) labelBuilder;
          final ValueChanged<T>? onSelected;
          final VoidCallback? onClear;

          const CustomFilterBar({
            super.key,
            required this.filters,
            required this.selectedFilters,
            required this.labelBuilder,
            this.onSelected,
            this.onClear,
          });

          @override
          Widget build(BuildContext context) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...filters.map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: AppSizes.sm),
                      child: FilterChip(
                        label: Text(labelBuilder(filter)),
                        selected: selectedFilters.contains(filter),
                        onSelected: (_) => onSelected?.call(filter),
                        selectedColor: AppColors.primaryLight,
                        checkmarkColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                  if (onClear != null)
                    ActionChip(
                      label: const Text('Clear'),
                      onPressed: onClear,
                      backgroundColor: AppColors.surface,
                      side: const BorderSide(color: AppColors.border),
                    ),
                ],
              ),
            );
          }
        }
    '''),
    "custom_refresh_wrapper.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';

        class CustomRefreshWrapper extends StatelessWidget {
          final Widget child;
          final Future<void> Function() onRefresh;
          final ScrollPhysics? physics;

          const CustomRefreshWrapper({
            super.key,
            required this.child,
            required this.onRefresh,
            this.physics,
          });

          @override
          Widget build(BuildContext context) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              physics: physics ?? const AlwaysScrollableScrollPhysics(),
              child: child,
            );
          }
        }
    '''),
    "custom_network_image.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';
        import 'custom_shimmer.dart';

        class CustomNetworkImage extends StatelessWidget {
          final String url;
          final double? width;
          final double? height;
          final BoxFit fit;
          final BorderRadius? borderRadius;
          final Widget? placeholder;
          final Widget? errorWidget;
          final Color? backgroundColor;

          const CustomNetworkImage({
            super.key,
            required this.url,
            this.width,
            this.height,
            this.fit = BoxFit.cover,
            this.borderRadius,
            this.placeholder,
            this.errorWidget,
            this.backgroundColor,
          });

          @override
          Widget build(BuildContext context) {
            final radius = borderRadius ?? BorderRadius.circular(AppSizes.radiusMd);
            return ClipRRect(
              borderRadius: radius,
              child: ColoredBox(
                color: backgroundColor ?? AppColors.shimmerBase,
                child: Image.network(
                  url,
                  width: width,
                  height: height,
                  fit: fit,
                  errorBuilder: (_, __, ___) => errorWidget ?? const Center(child: Icon(Icons.broken_image_outlined, color: AppColors.textHint)),
                  loadingBuilder: (_, child, progress) => progress == null ? child : (placeholder ?? CustomShimmer(height: height ?? AppSizes.xxl, width: width)),
                ),
              ),
            );
          }
        }
    '''),
    "pagination_controls.dart": dart(r'''
        import 'package:flutter/material.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_colors.dart';
        import 'package:__PACKAGE_NAME__/core/constants/app_sizes.dart';

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
    '''),
}


def package_name_from_pubspec(pubspec: Path) -> str:
    if not pubspec.exists():
        raise FileNotFoundError(f"pubspec.yaml not found: {pubspec}")
    match = re.search(r"^name:\s*([a-zA-Z0-9_]+)\s*$", pubspec.read_text(encoding="utf-8"), re.MULTILINE)
    if not match:
        raise ValueError("Could not find a valid package name in pubspec.yaml")
    return match.group(1)


def validate_constants(root: Path) -> None:
    colors = root / "lib" / "core" / "constants" / "app_colors.dart"
    sizes = root / "lib" / "core" / "constants" / "app_sizes.dart"
    missing = [str(path) for path in (colors, sizes) if not path.exists()]
    if missing:
        raise FileNotFoundError("Required constant files are missing:\n" + "\n".join(missing))

    color_text = colors.read_text(encoding="utf-8")
    size_text = sizes.read_text(encoding="utf-8")
    missing_colors = [name for name in APP_COLORS if f"static const Color {name}" not in color_text]
    missing_sizes = [name for name in APP_SIZES if f"static const double {name}" not in size_text]
    if missing_colors or missing_sizes:
        message = ["The existing constants do not expose all names required by the widget library."]
        if missing_colors:
            message.append("Missing colors: " + ", ".join(missing_colors))
        if missing_sizes:
            message.append("Missing sizes: " + ", ".join(missing_sizes))
        raise ValueError("\n".join(message))


def render(content: str, package_name: str) -> str:
    return content.replace("__PACKAGE_NAME__", package_name)


def write_widget(path: Path, content: str, overwrite: bool, dry_run: bool) -> str:
    if path.exists() and not overwrite:
        return "skipped"
    if not dry_run:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
    return "written"


def write_barrel_file(root: Path, package_name: str, overwrite: bool, dry_run: bool) -> str:
    exports = [
        *[f"export 'common/{name}';" for name in sorted(COMMON_WIDGETS)],
        *[f"export 'utility/{name}';" for name in sorted(UTILITY_WIDGETS)],
    ]
    content = "// Generated core widget exports.\n" + "\n".join(exports) + "\n"
    path = root / "lib" / "core" / "widgets" / "core_widgets.dart"
    return write_widget(path, content, overwrite, dry_run)


def run_dart_format(root: Path) -> None:
    result = subprocess.run(["dart", "format", "lib/core/widgets"], cwd=root, text=True)
    if result.returncode != 0:
        raise RuntimeError("dart format failed")


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate the complete modern core widget library.")
    parser.add_argument("--root", default=".", help="Flutter project root")
    parser.add_argument("--overwrite", "-o", action="store_true", help="Overwrite existing widget files")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be generated without writing")
    parser.add_argument("--format", action="store_true", help="Run dart format after generation")
    parser.add_argument("--skip-validation", action="store_true", help="Skip pubspec and constants validation")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    try:
        package_name = package_name_from_pubspec(root / "pubspec.yaml")
        if not args.skip_validation:
            validate_constants(root)
    except (FileNotFoundError, ValueError) as error:
        print(f"Validation failed: {error}", file=sys.stderr)
        return 1

    destinations = [
        (root / "lib" / "core" / "widgets" / "common", COMMON_WIDGETS),
        (root / "lib" / "core" / "widgets" / "utility", UTILITY_WIDGETS),
    ]
    counts = {"written": 0, "skipped": 0}
    for directory, templates in destinations:
        for filename, content in templates.items():
            result = write_widget(directory / filename, render(content, package_name), args.overwrite, args.dry_run)
            counts[result] += 1
            print(f"{result:>7}: {directory / filename}")

    if args.format and not args.dry_run:
        try:
            run_dart_format(root)
        except (FileNotFoundError, RuntimeError) as error:
            print(f"Formatting failed: {error}", file=sys.stderr)
            return 1

    barrel_result = write_barrel_file(root, package_name, args.overwrite, args.dry_run)
    counts[barrel_result] += 1
    print(f"{barrel_result:>7}: {root / 'lib' / 'core' / 'widgets' / 'core_widgets.dart'}")

    total = len(COMMON_WIDGETS) + len(UTILITY_WIDGETS)
    print(f"\nCore widgets processed: {total} plus barrel export")
    print(f"Written: {counts['written']} | Skipped: {counts['skipped']}")
    print("All generated widgets use AppColors and AppSizes for custom colors and dimensions.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

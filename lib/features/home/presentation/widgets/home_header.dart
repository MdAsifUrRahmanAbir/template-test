import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/avatar.dart';

/// Top welcome bar — avatar, greeting + user name, and a notification
/// bell with an unread-dot indicator.
class HomeHeader extends StatelessWidget {
  final String userName;
  final String? avatarUrl;
  final bool hasUnreadNotifications;
  final VoidCallback? onNotificationTap;

  const HomeHeader({
    super.key,
    required this.userName,
    this.avatarUrl,
    this.hasUnreadNotifications = false,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bottomNavBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAvatar(
                imageUrl: avatarUrl,
                label: userName,
                radius: AppSizes.md + AppSizes.xs / 2,
              ),
              const SizedBox(width: AppSizes.sm + AppSizes.xs),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.welcomeBack,
                    style: TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onNotificationTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: AppSizes.xl + AppSizes.xs,
                  height: AppSizes.xl + AppSizes.xs,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: AppSizes.iconSm,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (hasUnreadNotifications)
                  Positioned(
                    top: 0,
                    right: 2,
                    child: Container(
                      width: AppSizes.sm,
                      height: AppSizes.sm,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
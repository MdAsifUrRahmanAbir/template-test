import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../routes/route_names.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stats_row.dart';
import '../widgets/profile_settings_sections.dart';

class ProfileMobileView extends ConsumerWidget {
  const ProfileMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, AppSizes.xl),
        child: Column(
          children: [
            // TODO: replace hardcoded profile data with profileControllerProvider
            // once features/profile/data/repositories is implemented.
            const ProfileHeader(
              name: 'Alex Johnson',
              role: 'Workspace Admin',
            ),
            const SizedBox(height: AppSizes.lg),
            const ProfileStatsRow(projects: '24', tasks: '156', rating: '4.8'),
            const SizedBox(height: AppSizes.lg),
            ProfileSettingsSections(
              onPersonalInfoTap: () => context.go(RouteNames.editProfile),
              onNotificationSettingsTap: () => context.go(RouteNames.notifications),
              // TODO: wire remaining rows to their routes once those
              // screens/routes exist (language, privacy, connected apps,
              // 2FA, help center).
            ),
          ],
        ),
      ),
    );
  }
}
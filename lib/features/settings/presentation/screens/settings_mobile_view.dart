import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/utility/custom_alert_dialog.dart';
import '../../../../routes/route_names.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_toggles_section.dart';
import '../widgets/settings_security_general_section.dart';
import '../widgets/settings_legal_section.dart';
import '../widgets/settings_footer_actions.dart';

class SettingsMobileView extends ConsumerWidget {
  const SettingsMobileView({super.key});

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await CustomAlertDialog.confirm(
      context,
      title: AppStrings.deleteAccount,
      message: 'This action is permanent and cannot be undone. Are you sure?',
      confirmText: AppStrings.deleteAccount,
      destructive: true,
    );

    if (confirmed == true) {
      await ref.read(settingsControllerProvider.notifier).deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider.notifier);

    final state = ref.watch(settingsControllerProvider);

    return Column(
      children: [
        const AppHeaderBar(title: AppStrings.settingsTitle),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsTogglesSection(
                  darkMode: state.darkMode,
                  onDarkModeChanged: controller.setDarkMode,

                  onAppThemeTap: () {
                    // TODO: open app-theme picker
                  },

                  pushNotifications: state.pushNotifications,
                  onPushNotificationsChanged: controller.setPushNotifications,

                  emailNotifications: state.emailNotifications,
                  onEmailNotificationsChanged: controller.setEmailNotifications,

                  smsAlerts: state.smsAlerts,
                  onSmsAlertsChanged: controller.setSmsAlerts,
                ),

                const SizedBox(height: AppSizes.lg),

                SettingsSecurityGeneralSection(
                  biometricAuth: state.biometricAuth,
                  onBiometricAuthChanged: controller.setBiometricAuth,

                  onTwoFactorAuthTap: () {
                    // TODO: navigate to 2FA setup
                  },

                  onActiveSessionsTap: () {
                    // TODO: navigate to active sessions
                  },

                  onLanguageTap: () {
                    // TODO: open language picker
                  },

                  onRegionTap: () {
                    // TODO: open region picker
                  },

                  onChangePssword: () {
                    context.push(RouteNames.changePassword);
                  },
                ),

                const SizedBox(height: AppSizes.lg),

                SettingsLegalSection(
                  onTermsTap: () {
                    context.push(RouteNames.termsPrivacy);
                  },

                  onPrivacyTap: () {
                    context.push(RouteNames.termsPrivacy);
                  },

                  onLicensesTap: () {
                    context.push(RouteNames.helpSupport);
                  },
                ),

                const SizedBox(height: AppSizes.lg),

                SettingsFooterActions(
                  versionLabel: 'v2.4.1 (Build 2026)',

                  onLogOutTap: () {
                    // TODO: call authControllerProvider.logout()
                    // and navigate to RouteNames.login
                  },

                  onDeleteAccountTap: () {
                    _confirmDeleteAccount(context, ref);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

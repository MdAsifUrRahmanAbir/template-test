import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/utility/custom_alert_dialog.dart';
import '../widgets/settings_toggles_section.dart';
import '../widgets/settings_security_general_section.dart';
import '../widgets/settings_legal_section.dart';
import '../widgets/settings_footer_actions.dart';

class SettingsMobileView extends ConsumerStatefulWidget {
  const SettingsMobileView({super.key});

  @override
  ConsumerState<SettingsMobileView> createState() => _SettingsMobileViewState();
}

class _SettingsMobileViewState extends ConsumerState<SettingsMobileView> {
  // TODO: replace local toggle state with settingsControllerProvider
  // once features/settings/data/repositories is implemented.
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsAlerts = false;
  bool _biometricAuth = true;

  Future<void> _confirmDeleteAccount() async {
    final confirmed = await CustomAlertDialog.confirm(
      context,
      title: AppStrings.deleteAccount,
      message: 'This action is permanent and cannot be undone. Are you sure?',
      confirmText: AppStrings.deleteAccount,
      destructive: true,
    );
    if (confirmed == true) {
      // TODO: call settingsControllerProvider.deleteAccount()
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  darkMode: _darkMode,
                  onDarkModeChanged: (v) => setState(() => _darkMode = v),
                  onAppThemeTap: () {
                    // TODO: open app-theme picker
                  },
                  pushNotifications: _pushNotifications,
                  onPushNotificationsChanged: (v) => setState(() => _pushNotifications = v),
                  emailNotifications: _emailNotifications,
                  onEmailNotificationsChanged: (v) => setState(() => _emailNotifications = v),
                  smsAlerts: _smsAlerts,
                  onSmsAlertsChanged: (v) => setState(() => _smsAlerts = v),
                ),
                const SizedBox(height: AppSizes.lg),
                SettingsSecurityGeneralSection(
                  biometricAuth: _biometricAuth,
                  onBiometricAuthChanged: (v) => setState(() => _biometricAuth = v),
                  onTwoFactorAuthTap: () {
                    // TODO: navigate to 2FA setup once that route exists
                  },
                  onActiveSessionsTap: () {
                    // TODO: navigate to active sessions list once that route exists
                  },
                  onLanguageTap: () {
                    // TODO: open language picker
                  },
                  onRegionTap: () {
                    // TODO: open region picker
                  },
                ),
                const SizedBox(height: AppSizes.lg),
                SettingsLegalSection(
                  onTermsTap: () {
                    // TODO: open Terms of Service (external link or /terms route)
                  },
                  onPrivacyTap: () {
                    // TODO: open Privacy Policy (external link or /privacy-policy route)
                  },
                  onLicensesTap: () {
                    // TODO: navigate to open-source licenses once that route exists
                  },
                ),
                const SizedBox(height: AppSizes.lg),
                SettingsFooterActions(
                  versionLabel: 'v2.4.1 (Build 2026)',
                  onLogOutTap: () {
                    // TODO: call authControllerProvider.logout() and
                    // navigate to RouteNames.login
                  },
                  onDeleteAccountTap: _confirmDeleteAccount,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
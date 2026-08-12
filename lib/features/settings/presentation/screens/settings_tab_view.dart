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

/// Same content as [SettingsMobileView], centered in a fixed-width
/// column for wider (tablet/web) viewports.
class SettingsTabView extends ConsumerStatefulWidget {
  const SettingsTabView({super.key});

  @override
  ConsumerState<SettingsTabView> createState() => _SettingsTabViewState();
}

class _SettingsTabViewState extends ConsumerState<SettingsTabView> {
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
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.xl),
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
                    const SizedBox(height: AppSizes.xl),
                    SettingsSecurityGeneralSection(
                      biometricAuth: _biometricAuth,
                      onBiometricAuthChanged: (v) => setState(() => _biometricAuth = v),
                      onTwoFactorAuthTap: () {},
                      onActiveSessionsTap: () {},
                      onLanguageTap: () {},
                      onRegionTap: () {},
                    ),
                    const SizedBox(height: AppSizes.xl),
                    SettingsLegalSection(
                      onTermsTap: () {},
                      onPrivacyTap: () {},
                      onLicensesTap: () {},
                    ),
                    const SizedBox(height: AppSizes.xl),
                    SettingsFooterActions(
                      versionLabel: 'v2.4.1 (Build 2026)',
                      onLogOutTap: () {},
                      onDeleteAccountTap: _confirmDeleteAccount,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/password_input_field.dart';
import '../../../../core/widgets/common/password_strength_meter.dart';
import '../../../../core/widgets/common/primary_button.dart';

/// Current / new / confirm password fields + strength meter + Save
/// Changes button.
///
/// Purely presentational — owns only local UI state (controllers,
/// password-strength calculation, validation). The actual "change
/// password" call is supplied by the caller via [onSave], so this
/// widget doesn't reach into data/repositories.
class ChangePasswordForm extends StatefulWidget {
  final bool loading;
  final void Function(String currentPassword, String newPassword) onSave;

  const ChangePasswordForm({
    super.key,
    required this.onSave,
    this.loading = false,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  PasswordStrength _strengthOf(String password) {
    var score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$&*~%^()_\-+=]').hasMatch(password)) score++;

    return switch (score) {
      0 || 1 => PasswordStrength.weak,
      2 => PasswordStrength.fair,
      3 => PasswordStrength.good,
      _ => PasswordStrength.strong,
    };
  }

  String? _validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.currentPasswordRequired;
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    if (value == _currentPasswordController.text) return AppStrings.newPasswordSameAsCurrent;
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.confirmPasswordRequired;
    if (value != _newPasswordController.text) return AppStrings.passwordsDoNotMatch;
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(_currentPasswordController.text, _newPasswordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PasswordInputField(
            label: AppStrings.currentPassword,
            controller: _currentPasswordController,
            validator: _validateCurrentPassword,
          ),
          const SizedBox(height: AppSizes.lg),
          PasswordInputField(
            label: AppStrings.newPassword,
            controller: _newPasswordController,
            validator: _validateNewPassword,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSizes.lg),
          PasswordInputField(
            label: AppStrings.confirmPassword,
            controller: _confirmPasswordController,
            validator: _validateConfirmPassword,
          ),
          const SizedBox(height: AppSizes.xs),
          PasswordStrengthMeter(strength: _strengthOf(_newPasswordController.text)),
          const SizedBox(height: AppSizes.lg),
          PrimaryButton(
            label: AppStrings.saveChanges,
            loading: widget.loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
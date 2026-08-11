import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/password_input_field.dart';
import '../../../../core/widgets/common/primary_button.dart';
import '../../../../core/widgets/utility/password_requirement_item.dart';

/// New password + confirm password fields, a live requirements
/// checklist, and the Update Password button.
///
/// Purely presentational — owns only local UI state (controllers,
/// live validation flags). The actual password-update request is
/// supplied by the caller via [onSubmit], so this widget never
/// reaches into data/repositories.
class ResetPasswordForm extends StatefulWidget {
  final bool loading;
  final ValueChanged<String> onSubmit;

  const ResetPasswordForm({
    super.key,
    required this.onSubmit,
    this.loading = false,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  static final _symbolRegExp = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]');
  static final _numberRegExp = RegExp(r'[0-9]');

  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasSymbol = false;
  bool _passwordsMatch = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _revalidate() {
    final password = _passwordController.text;
    final confirm = _confirmController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasNumber = _numberRegExp.hasMatch(password);
      _hasSymbol = _symbolRegExp.hasMatch(password);
      _passwordsMatch = password.isNotEmpty && password == confirm;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    if (value.length < 8) return AppStrings.reqMinLength;
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    if (value != _passwordController.text) return AppStrings.reqMatch;
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(_passwordController.text);
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
            label: AppStrings.newPassword,
            controller: _passwordController,
            validator: _validatePassword,
            onChanged: (_) => _revalidate(),
          ),
          const SizedBox(height: AppSizes.lg),
          PasswordInputField(
            label: AppStrings.confirmPassword,
            controller: _confirmController,
            validator: _validateConfirm,
            onChanged: (_) => _revalidate(),
          ),
          const SizedBox(height: AppSizes.xs),
          PasswordRequirementItem(label: AppStrings.reqMinLength, met: _hasMinLength),
          PasswordRequirementItem(label: AppStrings.reqNumber, met: _hasNumber),
          PasswordRequirementItem(label: AppStrings.reqSymbol, met: _hasSymbol),
          PasswordRequirementItem(label: AppStrings.reqMatch, met: _passwordsMatch),
          const SizedBox(height: AppSizes.md),
          PrimaryButton(
            label: AppStrings.updatePassword,
            loading: widget.loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
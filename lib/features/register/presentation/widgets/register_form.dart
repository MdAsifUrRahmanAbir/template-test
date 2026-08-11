import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/primary_input_field.dart';
import '../../../../core/widgets/common/password_input_field.dart';
import '../../../../core/widgets/common/password_strength_meter.dart';
import '../../../../core/widgets/common/primary_checkbox.dart';
import '../../../../core/widgets/common/link_button.dart';
import '../../../../core/widgets/common/primary_button.dart';

/// Full name + email + password (with strength meter) + confirm
/// password + terms checkbox + Create Account button.
///
/// Purely presentational — owns only local UI state (controllers,
/// password-strength calculation, terms-agreed toggle, validation).
/// The actual registration call is supplied by the caller via
/// [onRegister], so this widget doesn't reach into data/repositories.
class RegisterForm extends StatefulWidget {
  final bool loading;
  final void Function(String fullName, String email, String password) onRegister;
  final VoidCallback? onTermsTap;

  const RegisterForm({
    super.key,
    required this.onRegister,
    this.onTermsTap,
    this.loading = false,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.fullNameRequired;
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.emailRequired;
    if (!value.contains('@')) return AppStrings.emailInvalid;
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.confirmPasswordRequired;
    if (value != _passwordController.text) return AppStrings.passwordsDoNotMatch;
    return null;
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.mustAgreeToTerms)),
      );
      return;
    }
    widget.onRegister(_nameController.text.trim(), _emailController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryInputField(
            label: AppStrings.fullName,
            hint: AppStrings.fullNameHint,
            controller: _nameController,
            prefixIcon: const Icon(Icons.person_outline_rounded),
            validator: _validateName,
          ),
          const SizedBox(height: AppSizes.md),
          PrimaryInputField(
            label: AppStrings.emailAddress,
            hint: AppStrings.registerEmailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.mail_outline_rounded),
            validator: _validateEmail,
          ),
          const SizedBox(height: AppSizes.md),
          PasswordInputField(
            label: AppStrings.password,
            hint: AppStrings.registerPasswordHint,
            controller: _passwordController,
            validator: _validatePassword,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSizes.sm),
          PasswordStrengthMeter(strength: _strengthOf(_passwordController.text)),
          const SizedBox(height: AppSizes.md),
          PasswordInputField(
            label: AppStrings.confirmPassword,
            hint: AppStrings.registerPasswordHint,
            controller: _confirmPasswordController,
            validator: _validateConfirmPassword,
          ),
          const SizedBox(height: AppSizes.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryCheckbox(
                value: _agreedToTerms,
                onChanged: (value) => setState(() => _agreedToTerms = value ?? false),
              ),
              const Text(
                AppStrings.agreeToTermsPrefix,
                style: TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textPrimary),
              ),
              LinkButton(
                label: AppStrings.termsAndConditions,
                fontSize: AppSizes.fontSm,
                onPressed: widget.onTermsTap,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          PrimaryButton(
            label: AppStrings.createAccount,
            loading: widget.loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
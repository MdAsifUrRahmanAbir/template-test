import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/primary_input_field.dart';
import '../../../../core/widgets/common/password_input_field.dart';
import '../../../../core/widgets/common/primary_checkbox.dart';
import '../../../../core/widgets/common/link_button.dart';
import '../../../../core/widgets/common/primary_button.dart';

/// Email + password fields, "Remember me" / "Forgot password?" row, and
/// the Sign In button.
///
/// Purely presentational — it owns only its local UI state (text
/// controllers, the remember-me checkbox, form validation). The actual
/// sign-in logic (calling the auth repository/controller) is supplied
/// by the caller via [onSignIn], so this widget stays reusable and
/// doesn't reach into data/repositories itself.
class LoginForm extends StatefulWidget {
  final bool loading;
  final void Function(String email, String password, bool rememberMe) onSignIn;
  final VoidCallback? onForgotPassword;

  const LoginForm({
    super.key,
    required this.onSignIn,
    this.onForgotPassword,
    this.loading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSignIn(_emailController.text.trim(), _passwordController.text, _rememberMe);
    }
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryInputField(
            label: AppStrings.emailAddress,
            hint: AppStrings.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.mail_outline_rounded),
            validator: _validateEmail,
          ),
          const SizedBox(height: AppSizes.md),
          PasswordInputField(
            label: AppStrings.password,
            hint: AppStrings.passwordHint,
            controller: _passwordController,
            validator: _validatePassword,
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            children: [
              Expanded(
                child: PrimaryCheckbox(
                  value: _rememberMe,
                  label: AppStrings.rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value ?? false),
                ),
              ),
              LinkButton(
                label: AppStrings.forgotPassword,
                fontSize: AppSizes.fontSm,
                onPressed: widget.onForgotPassword,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          PrimaryButton(
            label: AppStrings.signIn,
            loading: widget.loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

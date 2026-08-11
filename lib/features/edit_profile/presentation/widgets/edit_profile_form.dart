import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/common/primary_input_field.dart';
import '../../../../core/widgets/common/primary_button.dart';

/// Full Name / Email / Phone / Designation / Bio fields plus the
/// Save Changes button.
///
/// Purely presentational — owns only local UI state (controllers,
/// validation). The actual profile-update request is supplied by the
/// caller via [onSave], so this widget never reaches into
/// data/repositories.
class EditProfileForm extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String initialDesignation;
  final String initialBio;
  final bool loading;
  final bool showSaveButton;
  final void Function(Map<String, String> values) onSave;

  const EditProfileForm({
    super.key,
    required this.onSave,
    this.initialName = '',
    this.initialEmail = '',
    this.initialPhone = '',
    this.initialDesignation = '',
    this.initialBio = '',
    this.loading = false,
    this.showSaveButton = true,
  });

  @override
  State<EditProfileForm> createState() => EditProfileFormState();
}

class EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _designationController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _designationController = TextEditingController(text: widget.initialDesignation);
    _bioController = TextEditingController(text: widget.initialBio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _designationController.dispose();
    _bioController.dispose();
    super.dispose();
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

  /// Exposed so the caller (e.g. a "Done" tap in the app bar) can
  /// trigger the same submit path as the in-form button.
  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'designation': _designationController.text.trim(),
        'bio': _bioController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryInputField(
              label: AppStrings.fullName,
              controller: _nameController,
              validator: _validateName,
            ),
            const SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.emailAddress,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.phoneNumber,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: AppSizes.sm),
                child: Center(
                  widthFactor: 1,
                  child: Text(
                    '+1',
                    style: TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.designationTitle2,
              controller: _designationController,
            ),
            const SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.bio,
              controller: _bioController,
              maxLines: 4,
            ),
            if (widget.showSaveButton) ...[
              const SizedBox(height: AppSizes.lg),
              PrimaryButton(
                label: AppStrings.saveChanges,
                loading: widget.loading,
                onPressed: submit,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
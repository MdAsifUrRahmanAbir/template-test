import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../widgets/edit_profile_app_bar.dart';
import '../widgets/edit_profile_photo_section.dart';
import '../widgets/edit_profile_form.dart';

/// Same content as [EditProfileMobileView], centered in a
/// fixed-width column for wider (tablet/web) viewports.
class EditProfileTabView extends ConsumerStatefulWidget {
  const EditProfileTabView({super.key});

  @override
  ConsumerState<EditProfileTabView> createState() => _EditProfileTabViewState();
}

class _EditProfileTabViewState extends ConsumerState<EditProfileTabView> {
  final _formStateKey = GlobalKey<EditProfileFormState>();

  void _handleSave(Map<String, String> values) {
    // TODO: wire to profileControllerProvider.updateProfile(values)
    CustomSnackbar.show(context, 'Profile updated successfully');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditProfileAppBar(
        onDoneTap: () => _formStateKey.currentState?.submit(),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.xl),
            child: Column(
              children: [
                const EditProfilePhotoSection(name: 'Alex Johnson'),
                EditProfileForm(
                  key: _formStateKey,
                  initialName: 'Alex Johnson',
                  initialEmail: 'alex.johnson@enterprise.com',
                  initialPhone: '555-0199',
                  initialDesignation: 'Workspace Admin',
                  initialBio:
                  'Responsible for managing the enterprise cluster databases, '
                      'orchestrating deployments, and setting access token '
                      'permissions for the department nodes.',
                  onSave: _handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
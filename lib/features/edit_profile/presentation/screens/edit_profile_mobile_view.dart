import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../widgets/edit_profile_app_bar.dart';
import '../widgets/edit_profile_photo_section.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileMobileView extends ConsumerStatefulWidget {
  const EditProfileMobileView({super.key});

  @override
  ConsumerState<EditProfileMobileView> createState() => _EditProfileMobileViewState();
}

class _EditProfileMobileViewState extends ConsumerState<EditProfileMobileView> {
  final _formStateKey = GlobalKey<EditProfileFormState>();

  void _handleSave(Map<String, String> values) {
    // TODO: wire to profileControllerProvider.updateProfile(values)
    // once features/profile/data/repositories is implemented.
    CustomSnackbar.show(context, 'Profile updated successfully');
    context.pop();
  }

  @override
  Widget build(BuildContext context) { // <-- REMOVED 'WidgetRef ref' HERE
    return Scaffold(
      appBar: EditProfileAppBar(
        onDoneTap: () => _formStateKey.currentState?.submit(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            // TODO: replace hardcoded initial values with
            // profileControllerProvider once available.
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
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_test/features/onboarding/data/models/onboarding_model.dart';

class OnboardingController extends Notifier<List<OnboardingModel>> {
  @override
  List<OnboardingModel> build() {
    return const [
      OnboardingModel(
        title: 'Manage Inventory',
        description: 'Track stock and product availability in real time.',
        imagePath: 'assets/images/onboarding1.png',
      ),
      OnboardingModel(
        title: 'Fast Operations',
        description: 'Manage daily business operations efficiently and accurately.',
        imagePath: 'assets/images/onboarding2.png',
      ),
      OnboardingModel(
        title: 'Business Analytics',
        description: 'Gain valuable insights into daily sales and growth.',
        imagePath: 'assets/images/onboarding3.png',
      ),
    ];
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, List<OnboardingModel>>(OnboardingController.new);

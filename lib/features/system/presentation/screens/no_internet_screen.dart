import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/no_internet_content.dart';
import '../../../../core/utils/responsive.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: const NoInternetMobileView(),
        tablet: const NoInternetTabView(),
      ),
    );
  }
}





class NoInternetMobileView extends StatelessWidget {
  const NoInternetMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl, vertical: AppSizes.xxl),
      child: NoInternetContent(
        onCheckConnection: () {
          // TODO: re-check connectivity (e.g. via connectivity_plus)
          // once that package/repository integration exists.
        },
        onWorkOffline: () {
          // TODO: dismiss and continue in offline mode once an
          // offline-mode flag/provider exists.
        },
      ),
    );
  }
}



/// Same content as [NoInternetMobileView], centered in a fixed-width
/// column for wider (tablet/web) viewports.
class NoInternetTabView extends StatelessWidget {
  const NoInternetTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.xl),
          child: NoInternetContent(
            onCheckConnection: () {},
            onWorkOffline: () {},
          ),
        ),
      ),
    );
  }
}
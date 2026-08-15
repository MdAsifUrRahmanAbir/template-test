import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/route_names.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_brand_text.dart';
import '../widgets/splash_loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: const SplashMobileView(),
        tablet: const SplashTabView(),
      ),
    );
  }
}



class SplashMobileView extends StatefulWidget {
  const SplashMobileView({super.key});

  @override
  State<SplashMobileView> createState() => _SplashMobileViewState();
}

class _SplashMobileViewState extends State<SplashMobileView> {
  @override
  void initState() {
    super.initState();
    // TODO: replace with the real bootstrap check (auth token, app config...)
    // once the onboarding/data/repositories layer is ready.
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(RouteNames.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Spacer(flex: 3),
                const SplashLogo(),
                const SizedBox(height: AppSizes.lg),
                const SplashBrandText(),
                const Spacer(flex: 4),
                const SplashLoadingIndicator(),
                const SizedBox(height: AppSizes.xl),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



/// Same content as [SplashMobileView], centered in a fixed-width
/// column for wider (tablet/web) viewports.
class SplashTabView extends StatefulWidget {
  const SplashTabView({super.key});

  @override
  State<SplashTabView> createState() => _SplashTabViewState();
}

class _SplashTabViewState extends State<SplashTabView> {
  @override
  void initState() {
    super.initState();
    // TODO: replace with the real bootstrap check (auth token, app config...)
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(RouteNames.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Spacer(flex: 3),
                    const SplashLogo(),
                    const SizedBox(height: AppSizes.lg),
                    const SplashBrandText(),
                    const Spacer(flex: 4),
                    const SplashLoadingIndicator(),
                    const SizedBox(height: AppSizes.xl),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
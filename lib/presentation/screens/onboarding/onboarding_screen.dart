import 'package:budgets/presentation/screens/onboarding/components/welcome_sceeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';

import '../../resources/colors.dart';
import 'components/description_page.dart';
import 'components/get_started.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _IntroPager(),
    );
  }
}

class _IntroPager extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final currentPage = useState<int>(0);
    final PageController controller = usePageController();

    return SafeArea(
      child: Stack(
        children: [
          PageIndicatorContainer(
            padding: const EdgeInsets.only(bottom: 18),
            child: PageView(
              onPageChanged: (page) {
                currentPage.value = page;
              },
              controller: controller,
              children: [
                WelcomeScreen(),
                DescriptionPage(
                  imagePath: 'assets/images/logo.png',
                  text: AppLocalizations.of(context)!.onboarding_description_1,
                ),
                DescriptionPage(
                  imagePath: 'assets/images/logo.png',
                  text: AppLocalizations.of(context)!.onboarding_description_2,
                ),
                DescriptionPage(
                  imagePath: 'assets/images/logo.png',
                  text: AppLocalizations.of(context)!.onboarding_description_3,
                ),
                DescriptionPage(
                  imagePath: 'assets/images/logo.png',
                  text: AppLocalizations.of(context)!.onboarding_description_4,
                ),
                GetStarted(),
              ],
            ),
            length: 6,
            indicatorColor: AppColors.greyDisabled,
            indicatorSelectorColor: AppColors.primaryColor,
          ),
          if (currentPage.value != 5)
            Positioned(
              bottom: 0,
              right: 8,
              child: TextButton(
                child: Text(AppLocalizations.of(context)!.onboarding_skip),
                onPressed: () => controller.animateToPage(
                  5,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOutQuint,
                ),
              ),
            )
        ],
      ),
    );
  }
}

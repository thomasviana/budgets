import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';

import '../../resources/constants.dart';
import 'components/description_page.dart';
import 'components/get_started.dart';

class IntroScreen extends StatelessWidget {
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
    return SafeArea(
      child: AbsorbPointer(
        absorbing: false,
        child: PageIndicatorContainer(
          child: PageView(
            children: const [
              GetStarted(text: 'Swipe to learn more about the app'),
              DescriptionPage(
                imagePath: 'assets/images/logo.png',
                text: 'Register your incomes.',
              ),
              DescriptionPage(
                imagePath: 'assets/images/logo.png',
                text: 'Control your expenses.',
              ),
              DescriptionPage(
                imagePath: 'assets/images/logo.png',
                text: 'Track your growth with your assets.',
              ),
              DescriptionPage(
                imagePath: 'assets/images/logo.png',
                text: 'Know your debt.',
              ),
              GetStarted(
                text: 'Now your are ready.',
              ),
            ],
          ),
          length: 5,
          indicatorColor: kPrimayColor.withOpacity(0.3),
          indicatorSelectorColor: kPrimayColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/rounded_button.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/navigation/routes.dart';

import 'components/description_page.dart';
import 'components/get_started.dart';

class IntroScreen extends StatelessWidget {
  static Widget create(BuildContext context) => IntroScreen();

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
    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;

    return AbsorbPointer(
      absorbing: isSigningIn,
      child: PageIndicatorContainer(
        child: PageView(
          children: [
            GetStarted(text: 'Swipe to learn more about the app'),
            DescriptionPage(
              imagePath: 'assets/images/logo.png',
              text: 'Track your personasl finances.',
            ),
            DescriptionPage(
              imagePath: 'assets/images/logo.png',
              text: 'Review your stats and budgets.',
            ),
            DescriptionPage(
              imagePath: 'assets/images/logo.png',
              text: 'Add incomes and expenses.',
            ),
            DescriptionPage(
              imagePath: 'assets/images/logo.png',
              text: 'Have a good experience while manage your budgets.',
            ),
            GetStarted(
              text: '',
            ),
          ],
        ),
        length: 5,
        indicatorColor: kPrimayColor.withOpacity(0.3),
        indicatorSelectorColor: kPrimayColor,
      ),
    );
  }
}

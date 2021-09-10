import 'package:budgets/presentation/screens/auth/auth_screen.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';
import 'package:budgets/presentation/widgets/rounded_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = '/';
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
    final size = MediaQuery.of(context).size;
    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;

    return AbsorbPointer(
      absorbing: isSigningIn,
      child: PageIndicatorContainer(
        child: PageView(
          children: [
            _DescriptionPage(
              imagePath: 'assets/images/intro_image_1.png',
              text: 'Track your personasl finances.',
            ),
            _DescriptionPage(
              imagePath: 'assets/images/intro_image_2.png',
              text: 'Review your stats and budgets.',
            ),
            _DescriptionPage(
              imagePath: 'assets/images/intro_image_3.png',
              text: 'Add incomes and expenses.',
            ),
            _DescriptionPage(
              imagePath: 'assets/images/intro_image_4.png',
              text: 'Have a good experience while manage your budgets.',
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimayColor, kAccentColor],
                ),
              ),
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.donut_large,
                    size: 200,
                    color: Colors.white,
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 30),
                  RoundedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.auth);
                    },
                    label: 'Get Started',
                  )
                ],
              ),
            ),
          ],
        ),
        length: 4,
        indicatorColor: kPrimayColor.withOpacity(0.3),
        indicatorSelectorColor: kPrimayColor,
      ),
    );
  }
}

class _DescriptionPage extends StatelessWidget {
  final String imagePath;
  final String text;

  const _DescriptionPage({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              imagePath,
              width: 500,
              height: 500,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

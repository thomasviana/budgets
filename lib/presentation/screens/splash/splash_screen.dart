import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/auth/auth_cubit.dart';
import '../../routes/app_navigator.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          print('is Authenticated');
          AppNavigator.navigateToMainPage(context);
        } else if (state.isUnauthenticated) {
          print('is Unauthenticated');
          AppNavigator.navigateToIntroPage(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 24),
              Text(
                'Loading...',
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}

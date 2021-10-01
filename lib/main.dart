import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/navigation/routes.dart';
import 'data/repository/implementation/record_repository.dart';
import 'data/repository/implementation/user_repository.dart';
import 'bloc/cubit/auth_cubit.dart';
import 'bloc/cubit/record_cubit.dart';
import 'bloc/cubit/user_cubit.dart';

import 'constants.dart';
import 'data/repository/implementation/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authCubit = AuthCubit(AuthRepository());
  final userCubit = UserCubit(UserRepository());
  final recordCubit = RecordCubit(RecordRepository());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => authCubit..init(),
        ),
        BlocProvider(
          create: (context) => userCubit..getUser(),
        ),
        BlocProvider(
          create: (context) => recordCubit
            ..getRecords(
                (context.read<AuthCubit>().state as AuthSignedIn).user.uid),
        )
      ],
      child: MyApp.create(),
    ),
  );
}

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.intro, (route) => false);
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.main, (route) => false);
        }
      },
      child: MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Budgets App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimayColor,
        accentColor: kAccentColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      onGenerateRoute: Routes.routes,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.dart';
import 'presentation/core/auth/auth_cubit.dart';
import 'presentation/resources/themes.dart';
import 'presentation/routes/routes.dart';
import 'presentation/widgets/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..onAuthCheckRequested(),
      child: MaterialApp(
        title: 'Budgets App',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [appRouteObserver],
        builder: (context, child) {
          // This custom MediaQuery forces the app to ignore any
          // font-size set by the system to avoid errors with texts
          // getting clipped out or not rendered appropriately.
          //
          // This is by no intention a good solution and its only
          // purpose is to serve as a temporary fix.
          //
          // Additional design research and testing needs to be done
          // in order to find a proper layout scalability based on
          // font-size.
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        theme: AppTheme.light,
        home: WillPopScope(
          child: Navigator(
            key: navigatorKey,
            onGenerateRoute: Routes.routes,
            //observers: [appRouteObserver], review this later
          ),
          onWillPop: () async => !(await navigatorKey.currentState!.maybePop()),
        ),
        // onGenerateRoute: Routes.routes,
      ),
    );
  }
}

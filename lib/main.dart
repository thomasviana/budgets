import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';

import 'di/dependency_injection.dart';
import 'presentation/core/auth/auth_bloc.dart';
import 'presentation/core/date/date_bloc.dart';
import 'presentation/core/settings/settings_bloc.dart';
import 'presentation/resources/resources.dart';
import 'presentation/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final AppRouter _appRouter = AppRouter();
  final _authBloc = sl<AuthBloc>()..add(AuthStatusRequested());
  final _dateBloc = sl<DateBloc>();
  final _settingsBloc = sl<SettingsBloc>()
    ..add(GetUserAccounts())
    ..add(GetUserCategories())
    ..add(GetUserBudgets());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _authBloc,
        ),
        BlocProvider.value(
          value: _settingsBloc,
        ),
        BlocProvider.value(
          value: _dateBloc,
        ),
      ],
      child: MaterialApp(
        title: 'Budgets App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
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
            onGenerateRoute: _appRouter.routes,
          ),
          onWillPop: () async => !(await navigatorKey.currentState!.maybePop()),
        ),
      ),
    );
  }
}

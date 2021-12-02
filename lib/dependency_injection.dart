import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

final GetIt sl = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  $initGetIt(sl, environment: env);
}

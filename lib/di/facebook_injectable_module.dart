import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FacebookInjectableModule {
  @lazySingleton
  FacebookAuth get facebookAuth => FacebookAuth.instance;
}

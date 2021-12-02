// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:firebase_storage/firebase_storage.dart' as _i8;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;

import 'application/account.dart' as _i4;
import 'application/src/account/check_auth_status.dart' as _i16;
import 'application/src/account/create_account.dart' as _i17;
import 'application/src/account/get_profile_info.dart' as _i18;
import 'application/src/account/log_out.dart' as _i19;
import 'application/src/account/sign_in.dart' as _i20;
import 'application/src/records/record_cubit.dart' as _i11;
import 'domain/account.dart' as _i14;
import 'domain/records.dart' as _i12;
import 'infraestructure/src/account/auth/auth_service_impl.dart' as _i15;
import 'infraestructure/src/account/auth/user_firebase_prov.dart' as _i13;
import 'infraestructure/src/core/facebook_injectable_module.dart' as _i22;
import 'infraestructure/src/core/firebase_injectable_module.dart' as _i23;
import 'presentation/core/auth/auth_cubit.dart' as _i21;
import 'presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i3;
import 'presentation/screens/home/cubit/home_screen_cubit.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.factory<_i3.AuthScreenCubit>(() => _i3.AuthScreenCubit(
      get<_i4.SignIn>(), get<_i4.CreateAccount>(), get<_i4.CheckAuthStatus>()));
  gh.lazySingleton<_i5.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i6.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i7.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i8.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i9.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i10.HomeScreenCubit>(
      () => _i10.HomeScreenCubit(get<_i4.GetProfileInfo>()));
  gh.factory<_i11.RecordCubit>(
      () => _i11.RecordCubit(get<_i12.RecordRepositoryBase>()));
  gh.lazySingleton<_i13.UserFirebaseProv>(() => _i13.UserFirebaseProv(
      get<_i8.FirebaseStorage>(), get<_i7.FirebaseFirestore>()));
  gh.lazySingleton<_i14.AuthService>(() => _i15.AuthServiceImpl(
      get<_i6.FirebaseAuth>(),
      get<_i9.GoogleSignIn>(),
      get<_i5.FacebookAuth>(),
      get<_i13.UserFirebaseProv>()));
  gh.factory<_i16.CheckAuthStatus>(
      () => _i16.CheckAuthStatus(get<_i14.AuthService>()));
  gh.factory<_i17.CreateAccount>(
      () => _i17.CreateAccount(get<_i14.AuthService>()));
  gh.factory<_i18.GetProfileInfo>(
      () => _i18.GetProfileInfo(get<_i14.AuthService>()));
  gh.factory<_i19.LogOut>(() => _i19.LogOut(get<_i14.AuthService>()));
  gh.factory<_i20.SignIn>(() => _i20.SignIn(get<_i14.AuthService>()));
  gh.factory<_i21.AuthCubit>(
      () => _i21.AuthCubit(get<_i16.CheckAuthStatus>(), get<_i19.LogOut>()));
  return get;
}

class _$FacebookInjectableModule extends _i22.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i23.FirebaseInjectableModule {}

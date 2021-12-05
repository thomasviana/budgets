// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_storage/firebase_storage.dart' as _i9;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;

import 'application/account.dart' as _i4;
import 'application/src/account/check_auth_status.dart' as _i18;
import 'application/src/account/create_account.dart' as _i19;
import 'application/src/account/get_profile_info.dart' as _i20;
import 'application/src/account/log_out.dart' as _i21;
import 'application/src/account/pick_user_image.dart' as _i22;
import 'application/src/account/set_user_image.dart' as _i23;
import 'application/src/account/sign_in.dart' as _i24;
import 'application/src/account/update_user_info.dart' as _i25;
import 'application/src/records/record_cubit.dart' as _i12;
import 'domain/account.dart' as _i16;
import 'domain/records.dart' as _i13;
import 'infraestructure/src/account/auth/auth_service_impl.dart' as _i17;
import 'infraestructure/src/account/auth/user_firebase_prov.dart' as _i15;
import 'infraestructure/src/core/facebook_injectable_module.dart' as _i27;
import 'infraestructure/src/core/firebase_injectable_module.dart' as _i28;
import 'presentation/core/auth/auth_cubit.dart' as _i3;
import 'presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i5;
import 'presentation/screens/home/cubit/home_screen_cubit.dart' as _i11;
import 'presentation/screens/profile/cubit/profile_screen_cubit.dart' as _i26;
import 'presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.factory<_i3.AuthCubit>(() => _i3.AuthCubit(get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(), get<_i4.LogOut>()));
  gh.factory<_i5.AuthScreenCubit>(() => _i5.AuthScreenCubit(
      get<_i4.SignIn>(), get<_i4.CreateAccount>(), get<_i4.CheckAuthStatus>()));
  gh.lazySingleton<_i6.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i7.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i8.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i9.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i10.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i11.HomeScreenCubit>(
      () => _i11.HomeScreenCubit(get<_i4.GetProfileInfo>()));
  gh.factory<_i12.RecordCubit>(
      () => _i12.RecordCubit(get<_i13.RecordRepositoryBase>()));
  gh.factory<_i14.SettingsScreenCubit>(() => _i14.SettingsScreenCubit(
      get<_i4.CheckAuthStatus>(), get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i15.UserFirebaseProv>(() => _i15.UserFirebaseProv(
      get<_i9.FirebaseStorage>(), get<_i8.FirebaseFirestore>()));
  gh.lazySingleton<_i16.AuthService>(() => _i17.AuthServiceImpl(
      get<_i7.FirebaseAuth>(),
      get<_i10.GoogleSignIn>(),
      get<_i6.FacebookAuth>(),
      get<_i15.UserFirebaseProv>()));
  gh.factory<_i18.CheckAuthStatus>(
      () => _i18.CheckAuthStatus(get<_i16.AuthService>()));
  gh.factory<_i19.CreateAccount>(
      () => _i19.CreateAccount(get<_i16.AuthService>()));
  gh.factory<_i20.GetProfileInfo>(
      () => _i20.GetProfileInfo(get<_i16.AuthService>()));
  gh.factory<_i21.LogOut>(() => _i21.LogOut(get<_i16.AuthService>()));
  gh.factory<_i22.PickUserImage>(
      () => _i22.PickUserImage(get<_i16.AuthService>()));
  gh.factory<_i23.SetUserImage>(
      () => _i23.SetUserImage(get<_i16.AuthService>()));
  gh.factory<_i24.SignIn>(() => _i24.SignIn(get<_i16.AuthService>()));
  gh.factory<_i25.UpdateUserInfo>(
      () => _i25.UpdateUserInfo(get<_i16.AuthService>()));
  gh.factory<_i26.ProfileScreenCubit>(() => _i26.ProfileScreenCubit(
      get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(),
      get<_i25.UpdateUserInfo>(),
      get<_i23.SetUserImage>()));
  return get;
}

class _$FacebookInjectableModule extends _i27.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i28.FirebaseInjectableModule {}

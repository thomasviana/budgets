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
import 'package:image_picker/image_picker.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;

import 'application/account.dart' as _i4;
import 'application/src/account/check_auth_status.dart' as _i20;
import 'application/src/account/create_account.dart' as _i21;
import 'application/src/account/get_profile_info.dart' as _i22;
import 'application/src/account/log_out.dart' as _i23;
import 'application/src/account/pick_user_image.dart' as _i12;
import 'application/src/account/sign_in.dart' as _i24;
import 'application/src/account/update_user_info.dart' as _i25;
import 'application/src/records/record_cubit.dart' as _i14;
import 'domain/account.dart' as _i18;
import 'domain/records.dart' as _i15;
import 'infraestructure/src/account/auth/auth_service_impl.dart' as _i19;
import 'infraestructure/src/account/auth/user_firebase_prov.dart' as _i17;
import 'infraestructure/src/core/facebook_injectable_module.dart' as _i27;
import 'infraestructure/src/core/firebase_injectable_module.dart' as _i28;
import 'infraestructure/src/core/image_picker_injectable_module.dart' as _i29;
import 'presentation/core/auth/auth_cubit.dart' as _i26;
import 'presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i3;
import 'presentation/screens/home/cubit/home_screen_cubit.dart' as _i10;
import 'presentation/screens/profile/cubit/profile_screen_cubit.dart' as _i13;
import 'presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final imagePickerInjectableModule = _$ImagePickerInjectableModule();
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
  gh.lazySingleton<_i11.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i12.PickUserImage>(
      () => _i12.PickUserImage(get<_i11.ImagePicker>()));
  gh.factory<_i13.ProfileScreenCubit>(() => _i13.ProfileScreenCubit(
      get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(),
      get<_i4.UpdateUserInfo>(),
      get<_i4.PickUserImage>()));
  gh.factory<_i14.RecordCubit>(
      () => _i14.RecordCubit(get<_i15.RecordRepositoryBase>()));
  gh.factory<_i16.SettingsScreenCubit>(() => _i16.SettingsScreenCubit(
      get<_i4.CheckAuthStatus>(), get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i17.UserFirebaseProv>(() => _i17.UserFirebaseProv(
      get<_i8.FirebaseStorage>(), get<_i7.FirebaseFirestore>()));
  gh.lazySingleton<_i18.AuthService>(() => _i19.AuthServiceImpl(
      get<_i6.FirebaseAuth>(),
      get<_i9.GoogleSignIn>(),
      get<_i5.FacebookAuth>(),
      get<_i17.UserFirebaseProv>()));
  gh.factory<_i20.CheckAuthStatus>(
      () => _i20.CheckAuthStatus(get<_i18.AuthService>()));
  gh.factory<_i21.CreateAccount>(
      () => _i21.CreateAccount(get<_i18.AuthService>()));
  gh.factory<_i22.GetProfileInfo>(
      () => _i22.GetProfileInfo(get<_i18.AuthService>()));
  gh.factory<_i23.LogOut>(() => _i23.LogOut(get<_i18.AuthService>()));
  gh.factory<_i24.SignIn>(() => _i24.SignIn(get<_i18.AuthService>()));
  gh.factory<_i25.UpdateUserInfo>(
      () => _i25.UpdateUserInfo(get<_i18.AuthService>()));
  gh.factory<_i26.AuthCubit>(() => _i26.AuthCubit(get<_i20.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(), get<_i4.LogOut>()));
  return get;
}

class _$FacebookInjectableModule extends _i27.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i28.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i29.ImagePickerInjectableModule {}

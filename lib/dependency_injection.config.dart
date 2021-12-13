// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i9;
import 'package:firebase_auth/firebase_auth.dart' as _i8;
import 'package:firebase_storage/firebase_storage.dart' as _i10;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i11;
import 'package:image_picker/image_picker.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;

import 'application/account.dart' as _i4;
import 'application/src/account/check_auth_status.dart' as _i21;
import 'application/src/account/create_account.dart' as _i22;
import 'application/src/account/get_profile_info.dart' as _i23;
import 'application/src/account/log_out.dart' as _i24;
import 'application/src/account/pick_user_image.dart' as _i14;
import 'application/src/account/sign_in.dart' as _i25;
import 'application/src/account/update_user_info.dart' as _i26;
import 'application/src/records/record_cubit.dart' as _i15;
import 'domain/account.dart' as _i19;
import 'domain/records.dart' as _i16;
import 'infraestructure/src/account/auth/auth_service_impl.dart' as _i20;
import 'infraestructure/src/account/auth/user_firebase_prov.dart' as _i18;
import 'infraestructure/src/core/facebook_injectable_module.dart' as _i28;
import 'infraestructure/src/core/firebase_injectable_module.dart' as _i29;
import 'infraestructure/src/core/image_picker_injectable_module.dart' as _i30;
import 'presentation/categories/cubit/categories_screen_cubit.dart' as _i6;
import 'presentation/core/auth/auth_cubit.dart' as _i3;
import 'presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i5;
import 'presentation/screens/home/cubit/home_screen_cubit.dart' as _i12;
import 'presentation/screens/profile/cubit/profile_screen_cubit.dart' as _i27;
import 'presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final imagePickerInjectableModule = _$ImagePickerInjectableModule();
  gh.factory<_i3.AuthCubit>(() => _i3.AuthCubit(get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(), get<_i4.LogOut>()));
  gh.factory<_i5.AuthScreenCubit>(() => _i5.AuthScreenCubit(
      get<_i4.SignIn>(), get<_i4.CreateAccount>(), get<_i4.CheckAuthStatus>()));
  gh.factory<_i6.CategoriesScreenCubit>(() => _i6.CategoriesScreenCubit());
  gh.lazySingleton<_i7.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i8.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i9.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i10.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i11.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i12.HomeScreenCubit>(
      () => _i12.HomeScreenCubit(get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i13.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i14.PickUserImage>(
      () => _i14.PickUserImage(get<_i13.ImagePicker>()));
  gh.factory<_i15.RecordCubit>(
      () => _i15.RecordCubit(get<_i16.RecordRepositoryBase>()));
  gh.factory<_i17.SettingsScreenCubit>(() => _i17.SettingsScreenCubit(
      get<_i4.CheckAuthStatus>(), get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i18.UserFirebaseProv>(() => _i18.UserFirebaseProv(
      get<_i10.FirebaseStorage>(), get<_i9.FirebaseFirestore>()));
  gh.lazySingleton<_i19.AuthService>(() => _i20.AuthServiceImpl(
      get<_i8.FirebaseAuth>(),
      get<_i11.GoogleSignIn>(),
      get<_i7.FacebookAuth>(),
      get<_i18.UserFirebaseProv>()));
  gh.factory<_i21.CheckAuthStatus>(
      () => _i21.CheckAuthStatus(get<_i19.AuthService>()));
  gh.factory<_i22.CreateAccount>(
      () => _i22.CreateAccount(get<_i19.AuthService>()));
  gh.factory<_i23.GetProfileInfo>(
      () => _i23.GetProfileInfo(get<_i19.AuthService>()));
  gh.factory<_i24.LogOut>(() => _i24.LogOut(get<_i19.AuthService>()));
  gh.factory<_i25.SignIn>(() => _i25.SignIn(get<_i19.AuthService>()));
  gh.factory<_i26.UpdateUserInfo>(
      () => _i26.UpdateUserInfo(get<_i19.AuthService>()));
  gh.factory<_i27.ProfileScreenCubit>(() => _i27.ProfileScreenCubit(
      get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(),
      get<_i26.UpdateUserInfo>(),
      get<_i4.PickUserImage>()));
  return get;
}

class _$FacebookInjectableModule extends _i28.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i29.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i30.ImagePickerInjectableModule {}

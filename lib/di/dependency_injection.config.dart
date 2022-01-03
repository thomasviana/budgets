// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i17;
import 'package:firebase_auth/firebase_auth.dart' as _i16;
import 'package:firebase_storage/firebase_storage.dart' as _i18;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i15;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i20;
import 'package:image_picker/image_picker.dart' as _i22;
import 'package:injectable/injectable.dart' as _i2;

import '../core/account/application.dart' as _i4;
import '../core/account/domain.dart' as _i32;
import '../core/account/src/application/check_auth_status.dart' as _i34;
import '../core/account/src/application/create_account.dart' as _i35;
import '../core/account/src/application/get_profile_info.dart' as _i36;
import '../core/account/src/application/log_out.dart' as _i37;
import '../core/account/src/application/pick_user_image.dart' as _i23;
import '../core/account/src/application/sign_in.dart' as _i38;
import '../core/account/src/application/update_user_info.dart' as _i39;
import '../core/account/src/infrastructure/auth/auth_service_impl.dart' as _i33;
import '../core/account/src/infrastructure/auth/user_firebase_prov.dart'
    as _i31;
import '../core/categories/application.dart' as _i30;
import '../core/categories/domain.dart' as _i11;
import '../core/categories/infrastructure.dart' as _i6;
import '../core/categories/src/application/create_category.dart' as _i13;
import '../core/categories/src/application/delete_category.dart' as _i14;
import '../core/categories/src/application/get_categories.dart' as _i19;
import '../core/categories/src/application/update_category.dart' as _i29;
import '../core/categories/src/infrastructure/category_mapper.dart' as _i10;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i12;
import '../core/categories/src/infrastructure/db/categories_db.dart' as _i9;
import '../core/categories/src/infrastructure/db/categories_table.dart' as _i8;
import '../core/records/domain.dart' as _i26;
import '../core/records/src/application/record_cubit.dart' as _i25;
import '../presentation/core/auth/auth_cubit.dart' as _i3;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i5;
import '../presentation/screens/categories/categories_cubit/categories_screen_cubit.dart'
    as _i7;
import '../presentation/screens/categories/edit_category_cubit/edit_category_screen_cubit.dart'
    as _i40;
import '../presentation/screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart'
    as _i28;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i21;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i24;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i27;
import 'db_injectable_module.dart' as _i41;
import 'facebook_injectable_module.dart' as _i42;
import 'firebase_injectable_module.dart' as _i43;
import 'image_picker_injectable_module.dart'
    as _i44; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dbInjectableModule = _$DbInjectableModule();
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final imagePickerInjectableModule = _$ImagePickerInjectableModule();
  gh.factory<_i3.AuthCubit>(
      () => _i3.AuthCubit(get<_i4.CheckAuthStatus>(), get<_i4.LogOut>()));
  gh.factory<_i5.AuthScreenCubit>(() => _i5.AuthScreenCubit(
      get<_i4.SignIn>(), get<_i4.CreateAccount>(), get<_i4.CheckAuthStatus>()));
  gh.lazySingleton<_i6.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.factory<_i7.CategoriesScreenCubit>(() => _i7.CategoriesScreenCubit());
  gh.lazySingleton<_i8.CategoryDao>(
      () => _i8.CategoryDao(get<_i9.CategoriesDatabase>()));
  gh.lazySingleton<_i10.CategoryMapper>(() => _i10.CategoryMapper());
  gh.lazySingleton<_i11.CategoryRepository>(() => _i12.CategoryRepositoryImpl(
      get<_i6.CategoryDao>(), get<_i6.CategoryMapper>()));
  gh.factory<_i13.CreateCategory>(
      () => _i13.CreateCategory(get<_i11.CategoryRepository>()));
  gh.factory<_i14.DeleteCategory>(
      () => _i14.DeleteCategory(get<_i11.CategoryRepository>()));
  gh.lazySingleton<_i15.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i16.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i17.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i18.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i19.GetCategories>(
      () => _i19.GetCategories(get<_i11.CategoryRepository>()));
  gh.lazySingleton<_i20.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i21.HomeScreenCubit>(
      () => _i21.HomeScreenCubit(get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i22.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i23.PickUserImage>(
      () => _i23.PickUserImage(get<_i22.ImagePicker>()));
  gh.factory<_i24.ProfileScreenCubit>(() => _i24.ProfileScreenCubit(
      get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(),
      get<_i4.UpdateUserInfo>(),
      get<_i4.PickUserImage>()));
  gh.factory<_i25.RecordCubit>(
      () => _i25.RecordCubit(get<_i26.RecordRepositoryBase>()));
  gh.factory<_i27.SettingsScreenCubit>(() => _i27.SettingsScreenCubit(
      get<_i4.CheckAuthStatus>(), get<_i4.GetProfileInfo>()));
  gh.factory<_i28.SubCategoriesScreenCubit>(
      () => _i28.SubCategoriesScreenCubit());
  gh.factory<_i29.UpdateCategory>(() => _i29.UpdateCategory(
      get<_i11.CategoryRepository>(), get<_i30.GetCategories>()));
  gh.lazySingleton<_i31.UserFirebaseProv>(() => _i31.UserFirebaseProv(
      get<_i18.FirebaseStorage>(), get<_i17.FirebaseFirestore>()));
  gh.lazySingleton<_i32.AuthService>(() => _i33.AuthServiceImpl(
      get<_i16.FirebaseAuth>(),
      get<_i20.GoogleSignIn>(),
      get<_i15.FacebookAuth>(),
      get<_i31.UserFirebaseProv>()));
  gh.factory<_i34.CheckAuthStatus>(
      () => _i34.CheckAuthStatus(get<_i32.AuthService>()));
  gh.factory<_i35.CreateAccount>(
      () => _i35.CreateAccount(get<_i32.AuthService>()));
  gh.factory<_i36.GetProfileInfo>(
      () => _i36.GetProfileInfo(get<_i32.AuthService>()));
  gh.factory<_i37.LogOut>(() => _i37.LogOut(get<_i32.AuthService>()));
  gh.factory<_i38.SignIn>(() => _i38.SignIn(get<_i32.AuthService>()));
  gh.factory<_i39.UpdateUserInfo>(
      () => _i39.UpdateUserInfo(get<_i32.AuthService>()));
  gh.factory<_i40.EditCategoryScreenCubit>(() => _i40.EditCategoryScreenCubit(
      get<_i30.UpdateCategory>(),
      get<_i30.DeleteCategory>(),
      get<_i36.GetProfileInfo>()));
  return get;
}

class _$DbInjectableModule extends _i41.DbInjectableModule {}

class _$FacebookInjectableModule extends _i42.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i43.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i44.ImagePickerInjectableModule {}

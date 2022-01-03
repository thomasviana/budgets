// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i14;
import 'package:firebase_auth/firebase_auth.dart' as _i13;
import 'package:firebase_storage/firebase_storage.dart' as _i15;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i16;
import 'package:image_picker/image_picker.dart' as _i18;
import 'package:injectable/injectable.dart' as _i2;

import '../core/account/application.dart' as _i4;
import '../core/account/domain.dart' as _i27;
import '../core/account/src/application/check_auth_status.dart' as _i31;
import '../core/account/src/application/create_account.dart' as _i32;
import '../core/account/src/application/get_profile_info.dart' as _i36;
import '../core/account/src/application/log_out.dart' as _i37;
import '../core/account/src/application/pick_user_image.dart' as _i20;
import '../core/account/src/application/sign_in.dart' as _i39;
import '../core/account/src/application/update_user_info.dart' as _i41;
import '../core/account/src/infrastructure/auth/auth_service_impl.dart' as _i28;
import '../core/account/src/infrastructure/auth/user_firebase_prov.dart'
    as _i26;
import '../core/categories/application.dart' as _i5;
import '../core/categories/domain.dart' as _i29;
import '../core/categories/infrastructure.dart' as _i7;
import '../core/categories/src/application/create_category.dart' as _i33;
import '../core/categories/src/application/delete_category.dart' as _i34;
import '../core/categories/src/application/get_categories.dart' as _i35;
import '../core/categories/src/application/save_categories.dart' as _i38;
import '../core/categories/src/application/update_category.dart' as _i40;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i30;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i10;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i9;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i11;
import '../core/categories/src/infrastructure/datasources/local/local_data_source.dart'
    as _i19;
import '../core/records/domain.dart' as _i23;
import '../core/records/src/application/record_cubit.dart' as _i22;
import '../presentation/core/auth/auth_cubit.dart' as _i3;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i6;
import '../presentation/screens/categories/categories_cubit/categories_screen_cubit.dart'
    as _i8;
import '../presentation/screens/categories/edit_category_cubit/edit_category_screen_cubit.dart'
    as _i42;
import '../presentation/screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart'
    as _i25;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i17;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i21;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i24;
import 'db_injectable_module.dart' as _i43;
import 'facebook_injectable_module.dart' as _i44;
import 'firebase_injectable_module.dart' as _i45;
import 'image_picker_injectable_module.dart'
    as _i46; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dbInjectableModule = _$DbInjectableModule();
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final imagePickerInjectableModule = _$ImagePickerInjectableModule();
  gh.factory<_i3.AuthCubit>(() => _i3.AuthCubit(get<_i4.CheckAuthStatus>(),
      get<_i5.GetCategories>(), get<_i5.SaveCategories>(), get<_i4.LogOut>()));
  gh.factory<_i6.AuthScreenCubit>(() => _i6.AuthScreenCubit(
      get<_i4.SignIn>(), get<_i4.CreateAccount>(), get<_i4.CheckAuthStatus>()));
  gh.lazySingleton<_i7.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.factory<_i8.CategoriesScreenCubit>(() => _i8.CategoriesScreenCubit(
      get<_i5.GetCategories>(),
      get<_i4.GetProfileInfo>(),
      get<_i5.CreateCategory>(),
      get<_i5.SaveCategories>()));
  gh.lazySingleton<_i9.CategoryDao>(
      () => _i9.CategoryDao(get<_i10.CategoriesDatabase>()));
  gh.lazySingleton<_i11.CategoryMapper>(() => _i11.CategoryMapper());
  gh.lazySingleton<_i12.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i13.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i14.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i15.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i16.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i17.HomeScreenCubit>(
      () => _i17.HomeScreenCubit(get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i18.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.lazySingleton<_i19.LocalDataSource>(() => _i19.LocalDataSourceImpl(
      get<_i9.CategoryDao>(), get<_i11.CategoryMapper>()));
  gh.factory<_i20.PickUserImage>(
      () => _i20.PickUserImage(get<_i18.ImagePicker>()));
  gh.factory<_i21.ProfileScreenCubit>(() => _i21.ProfileScreenCubit(
      get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(),
      get<_i4.UpdateUserInfo>(),
      get<_i4.PickUserImage>()));
  gh.factory<_i22.RecordCubit>(
      () => _i22.RecordCubit(get<_i23.RecordRepositoryBase>()));
  gh.factory<_i24.SettingsScreenCubit>(() => _i24.SettingsScreenCubit(
      get<_i4.CheckAuthStatus>(), get<_i4.GetProfileInfo>()));
  gh.factory<_i25.SubCategoriesScreenCubit>(
      () => _i25.SubCategoriesScreenCubit());
  gh.lazySingleton<_i26.UserFirebaseProv>(() => _i26.UserFirebaseProv(
      get<_i15.FirebaseStorage>(), get<_i14.FirebaseFirestore>()));
  gh.lazySingleton<_i27.AuthService>(() => _i28.AuthServiceImpl(
      get<_i13.FirebaseAuth>(),
      get<_i16.GoogleSignIn>(),
      get<_i12.FacebookAuth>(),
      get<_i26.UserFirebaseProv>()));
  gh.lazySingleton<_i29.CategoryRepository>(
      () => _i30.CategoryRepositoryImpl(get<_i19.LocalDataSource>()));
  gh.factory<_i31.CheckAuthStatus>(
      () => _i31.CheckAuthStatus(get<_i27.AuthService>()));
  gh.factory<_i32.CreateAccount>(
      () => _i32.CreateAccount(get<_i27.AuthService>()));
  gh.factory<_i33.CreateCategory>(
      () => _i33.CreateCategory(get<_i29.CategoryRepository>()));
  gh.factory<_i34.DeleteCategory>(
      () => _i34.DeleteCategory(get<_i29.CategoryRepository>()));
  gh.factory<_i35.GetCategories>(
      () => _i35.GetCategories(get<_i29.CategoryRepository>()));
  gh.factory<_i36.GetProfileInfo>(
      () => _i36.GetProfileInfo(get<_i27.AuthService>()));
  gh.factory<_i37.LogOut>(() => _i37.LogOut(get<_i27.AuthService>()));
  gh.factory<_i38.SaveCategories>(
      () => _i38.SaveCategories(get<_i29.CategoryRepository>()));
  gh.factory<_i39.SignIn>(() => _i39.SignIn(get<_i27.AuthService>()));
  gh.factory<_i40.UpdateCategory>(() => _i40.UpdateCategory(
      get<_i29.CategoryRepository>(), get<_i5.GetCategories>()));
  gh.factory<_i41.UpdateUserInfo>(
      () => _i41.UpdateUserInfo(get<_i27.AuthService>()));
  gh.factory<_i42.EditCategoryScreenCubit>(() => _i42.EditCategoryScreenCubit(
      get<_i5.UpdateCategory>(),
      get<_i5.DeleteCategory>(),
      get<_i36.GetProfileInfo>()));
  return get;
}

class _$DbInjectableModule extends _i43.DbInjectableModule {}

class _$FacebookInjectableModule extends _i44.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i45.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i46.ImagePickerInjectableModule {}

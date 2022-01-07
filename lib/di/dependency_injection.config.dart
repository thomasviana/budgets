// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i19;
import 'package:firebase_auth/firebase_auth.dart' as _i18;
import 'package:firebase_storage/firebase_storage.dart' as _i20;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i22;
import 'package:image_picker/image_picker.dart' as _i24;
import 'package:injectable/injectable.dart' as _i2;

import '../core/account/application.dart' as _i4;
import '../core/account/domain.dart' as _i38;
import '../core/account/src/application/check_auth_status.dart' as _i40;
import '../core/account/src/application/create_account.dart' as _i41;
import '../core/account/src/application/get_profile_info.dart' as _i44;
import '../core/account/src/application/log_out.dart' as _i46;
import '../core/account/src/application/pick_user_image.dart' as _i26;
import '../core/account/src/application/sign_in.dart' as _i48;
import '../core/account/src/application/update_user_info.dart' as _i49;
import '../core/account/src/infrastructure/auth/auth_service_impl.dart' as _i39;
import '../core/account/src/infrastructure/auth/user_firebase_prov.dart'
    as _i37;
import '../core/categories/application.dart' as _i5;
import '../core/categories/domain.dart' as _i12;
import '../core/categories/infrastructure.dart' as _i7;
import '../core/categories/src/application/create_category.dart' as _i14;
import '../core/categories/src/application/create_sub_category.dart' as _i42;
import '../core/categories/src/application/delete_category.dart' as _i15;
import '../core/categories/src/application/delete_sub_category.dart' as _i43;
import '../core/categories/src/application/get_categories.dart' as _i21;
import '../core/categories/src/application/get_sub_categories.dart' as _i45;
import '../core/categories/src/application/save_categories.dart' as _i30;
import '../core/categories/src/application/save_sub_categories.dart' as _i47;
import '../core/categories/src/application/update_category.dart' as _i35;
import '../core/categories/src/application/update_sub_category.dart' as _i36;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i13;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i10;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i9;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i11;
import '../core/categories/src/infrastructure/datasources/local/local_data_source.dart'
    as _i25;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i33;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i34;
import '../core/records/domain.dart' as _i29;
import '../core/records/src/application/record_cubit.dart' as _i28;
import '../presentation/core/auth/auth_cubit.dart' as _i3;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i6;
import '../presentation/screens/categories/categories_cubit/categories_screen_cubit.dart'
    as _i8;
import '../presentation/screens/categories/edit_category_cubit/edit_category_screen_cubit.dart'
    as _i50;
import '../presentation/screens/categories/edit_sub_category_cubit/edit_sub_category_screen_cubit.dart'
    as _i16;
import '../presentation/screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart'
    as _i32;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i23;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i27;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i31;
import 'db_injectable_module.dart' as _i51;
import 'facebook_injectable_module.dart' as _i52;
import 'firebase_injectable_module.dart' as _i53;
import 'image_picker_injectable_module.dart'
    as _i54; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i12.CategoryRepository>(
      () => _i13.CategoryRepositoryImpl(get<_i7.LocalDataSource>()));
  gh.factory<_i14.CreateCategory>(
      () => _i14.CreateCategory(get<_i12.CategoryRepository>()));
  gh.factory<_i15.DeleteCategory>(
      () => _i15.DeleteCategory(get<_i12.CategoryRepository>()));
  gh.factory<_i16.EditSubCategoryScreenCubit>(() =>
      _i16.EditSubCategoryScreenCubit(
          get<_i5.UpdateSubCategory>(), get<_i5.DeleteSubCategory>()));
  gh.lazySingleton<_i17.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i18.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i19.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i20.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i21.GetCategories>(
      () => _i21.GetCategories(get<_i12.CategoryRepository>()));
  gh.lazySingleton<_i22.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i23.HomeScreenCubit>(
      () => _i23.HomeScreenCubit(get<_i4.GetProfileInfo>()));
  gh.lazySingleton<_i24.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.lazySingleton<_i25.LocalDataSource>(() => _i25.LocalDataSourceImpl(
      get<_i7.CategoryDao>(),
      get<_i7.SubCategoryDao>(),
      get<_i7.CategoryMapper>(),
      get<_i7.SubCategoryMapper>()));
  gh.factory<_i26.PickUserImage>(
      () => _i26.PickUserImage(get<_i24.ImagePicker>()));
  gh.factory<_i27.ProfileScreenCubit>(() => _i27.ProfileScreenCubit(
      get<_i4.CheckAuthStatus>(),
      get<_i4.GetProfileInfo>(),
      get<_i4.UpdateUserInfo>(),
      get<_i4.PickUserImage>()));
  gh.factory<_i28.RecordCubit>(
      () => _i28.RecordCubit(get<_i29.RecordRepositoryBase>()));
  gh.factory<_i30.SaveCategories>(
      () => _i30.SaveCategories(get<_i12.CategoryRepository>()));
  gh.factory<_i31.SettingsScreenCubit>(() => _i31.SettingsScreenCubit(
      get<_i4.CheckAuthStatus>(), get<_i4.GetProfileInfo>()));
  gh.factory<_i32.SubCategoriesScreenCubit>(() => _i32.SubCategoriesScreenCubit(
      get<_i5.GetSubCategories>(), get<_i5.SaveSubCategories>()));
  gh.lazySingleton<_i9.SubCategoryDao>(
      () => _i9.SubCategoryDao(get<_i10.CategoriesDatabase>()));
  gh.lazySingleton<_i33.SubCategoryMapper>(() => _i33.SubCategoryMapper());
  gh.lazySingleton<_i12.SubCategoryRepository>(
      () => _i34.SubCategoryRepositoryImpl(get<_i7.LocalDataSource>()));
  gh.factory<_i35.UpdateCategory>(() => _i35.UpdateCategory(
      get<_i12.CategoryRepository>(), get<_i5.GetCategories>()));
  gh.factory<_i36.UpdateSubCategory>(() => _i36.UpdateSubCategory(
      get<_i12.SubCategoryRepository>(), get<_i5.GetSubCategories>()));
  gh.lazySingleton<_i37.UserFirebaseProv>(() => _i37.UserFirebaseProv(
      get<_i20.FirebaseStorage>(), get<_i19.FirebaseFirestore>()));
  gh.lazySingleton<_i38.AuthService>(() => _i39.AuthServiceImpl(
      get<_i18.FirebaseAuth>(),
      get<_i22.GoogleSignIn>(),
      get<_i17.FacebookAuth>(),
      get<_i37.UserFirebaseProv>()));
  gh.factory<_i40.CheckAuthStatus>(
      () => _i40.CheckAuthStatus(get<_i38.AuthService>()));
  gh.factory<_i41.CreateAccount>(
      () => _i41.CreateAccount(get<_i38.AuthService>()));
  gh.factory<_i42.CreateSubCategory>(
      () => _i42.CreateSubCategory(get<_i12.SubCategoryRepository>()));
  gh.factory<_i43.DeleteSubCategory>(
      () => _i43.DeleteSubCategory(get<_i12.SubCategoryRepository>()));
  gh.factory<_i44.GetProfileInfo>(
      () => _i44.GetProfileInfo(get<_i38.AuthService>()));
  gh.factory<_i45.GetSubCategories>(
      () => _i45.GetSubCategories(get<_i12.SubCategoryRepository>()));
  gh.factory<_i46.LogOut>(() => _i46.LogOut(get<_i38.AuthService>()));
  gh.factory<_i47.SaveSubCategories>(
      () => _i47.SaveSubCategories(get<_i12.SubCategoryRepository>()));
  gh.factory<_i48.SignIn>(() => _i48.SignIn(get<_i38.AuthService>()));
  gh.factory<_i49.UpdateUserInfo>(
      () => _i49.UpdateUserInfo(get<_i38.AuthService>()));
  gh.factory<_i50.EditCategoryScreenCubit>(() => _i50.EditCategoryScreenCubit(
      get<_i5.UpdateCategory>(),
      get<_i5.DeleteCategory>(),
      get<_i44.GetProfileInfo>(),
      get<_i5.GetSubCategories>(),
      get<_i5.SaveSubCategories>(),
      get<_i5.CreateSubCategory>(),
      get<_i5.CreateCategory>()));
  return get;
}

class _$DbInjectableModule extends _i51.DbInjectableModule {}

class _$FacebookInjectableModule extends _i52.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i53.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i54.ImagePickerInjectableModule {}

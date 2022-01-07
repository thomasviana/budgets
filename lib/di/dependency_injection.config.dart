// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i33;
import 'package:firebase_auth/firebase_auth.dart' as _i32;
import 'package:firebase_storage/firebase_storage.dart' as _i34;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i31;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i37;
import 'package:image_picker/image_picker.dart' as _i39;
import 'package:injectable/injectable.dart' as _i2;

import '../core/accounts/application.dart' as _i11;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/create_account.dart' as _i24;
import '../core/accounts/src/application/delete_account.dart' as _i26;
import '../core/accounts/src/application/get_accounts.dart' as _i35;
import '../core/accounts/src/application/save_accounts.dart' as _i44;
import '../core/accounts/src/application/update_account.dart' as _i50;
import '../core/accounts/src/infrastructure/account_repository_impl.dart'
    as _i7;
import '../core/accounts/src/infrastructure/datasources/local/account_mapper.dart'
    as _i5;
import '../core/accounts/src/infrastructure/datasources/local/accounts_db.dart'
    as _i4;
import '../core/accounts/src/infrastructure/datasources/local/accounts_local_data_source.dart'
    as _i9;
import '../core/accounts/src/infrastructure/datasources/local/accounts_table.dart'
    as _i3;
import '../core/categories/application.dart' as _i14;
import '../core/categories/domain.dart' as _i22;
import '../core/categories/infrastructure.dart' as _i16;
import '../core/categories/src/application/create_category.dart' as _i25;
import '../core/categories/src/application/create_sub_category.dart' as _i57;
import '../core/categories/src/application/delete_category.dart' as _i27;
import '../core/categories/src/application/delete_sub_category.dart' as _i59;
import '../core/categories/src/application/get_categories.dart' as _i36;
import '../core/categories/src/application/get_sub_categories.dart' as _i61;
import '../core/categories/src/application/save_categories.dart' as _i45;
import '../core/categories/src/application/save_sub_categories.dart' as _i63;
import '../core/categories/src/application/update_category.dart' as _i51;
import '../core/categories/src/application/update_sub_category.dart' as _i52;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i23;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i20;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i17;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i19;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i21;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i48;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i49;
import '../core/records/domain.dart' as _i43;
import '../core/records/src/application/record_cubit.dart' as _i42;
import '../core/user/application.dart' as _i12;
import '../core/user/domain.dart' as _i54;
import '../core/user/src/application/check_auth_status.dart' as _i56;
import '../core/user/src/application/create_user.dart' as _i58;
import '../core/user/src/application/get_profile_info.dart' as _i60;
import '../core/user/src/application/log_out.dart' as _i62;
import '../core/user/src/application/pick_user_image.dart' as _i40;
import '../core/user/src/application/sign_in.dart' as _i64;
import '../core/user/src/application/update_user_info.dart' as _i65;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i55;
import '../core/user/src/infrastructure/auth/user_firebase_prov.dart' as _i53;
import '../presentation/core/auth/auth_cubit.dart' as _i13;
import '../presentation/screens/accounts/accounts_cubit/accounts_screen_cubit.dart'
    as _i10;
import '../presentation/screens/accounts/edit_account_cubit/edit_account_screen_cubit.dart'
    as _i28;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i15;
import '../presentation/screens/categories/categories_cubit/categories_screen_cubit.dart'
    as _i18;
import '../presentation/screens/categories/edit_category_cubit/edit_category_screen_cubit.dart'
    as _i29;
import '../presentation/screens/categories/edit_sub_category_cubit/edit_sub_category_screen_cubit.dart'
    as _i30;
import '../presentation/screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart'
    as _i47;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i38;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i41;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i46;
import 'db_injectable_module.dart' as _i66;
import 'facebook_injectable_module.dart' as _i67;
import 'firebase_injectable_module.dart' as _i68;
import 'image_picker_injectable_module.dart'
    as _i69; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dbInjectableModule = _$DbInjectableModule();
  final facebookInjectableModule = _$FacebookInjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final imagePickerInjectableModule = _$ImagePickerInjectableModule();
  gh.lazySingleton<_i3.AccountDao>(
      () => _i3.AccountDao(get<_i4.AccountsDatabase>()));
  gh.lazySingleton<_i5.AccountMapper>(() => _i5.AccountMapper());
  gh.lazySingleton<_i6.AccountRepository>(
      () => _i7.AccountRepositoryImpl(get<_i8.AccountsLocalDataSource>()));
  gh.lazySingleton<_i8.AccountsDatabase>(
      () => dbInjectableModule.accountsDatabase);
  gh.lazySingleton<_i9.AccountsLocalDataSource>(() =>
      _i9.AccountsLocalDataSourceImpl(
          get<_i8.AccountDao>(), get<_i8.AccountMapper>()));
  gh.factory<_i10.AccountsScreenCubit>(() => _i10.AccountsScreenCubit(
      get<_i11.GetAccounts>(),
      get<_i12.GetProfileInfo>(),
      get<_i11.CreateAccount>(),
      get<_i11.SaveAccounts>()));
  gh.factory<_i13.AuthCubit>(() => _i13.AuthCubit(
      get<_i12.CheckAuthStatus>(),
      get<_i14.GetCategories>(),
      get<_i14.SaveCategories>(),
      get<_i12.LogOut>()));
  gh.factory<_i15.AuthScreenCubit>(() => _i15.AuthScreenCubit(
      get<_i12.SignIn>(), get<_i12.CreateUser>(), get<_i12.CheckAuthStatus>()));
  gh.lazySingleton<_i16.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i17.CategoriesLocalDataSource>(() =>
      _i17.CategoriesLocalDataSourceImpl(
          get<_i16.CategoryDao>(),
          get<_i16.SubCategoryDao>(),
          get<_i16.CategoryMapper>(),
          get<_i16.SubCategoryMapper>()));
  gh.factory<_i18.CategoriesScreenCubit>(() => _i18.CategoriesScreenCubit(
      get<_i14.GetCategories>(),
      get<_i12.GetProfileInfo>(),
      get<_i14.CreateCategory>(),
      get<_i14.SaveCategories>()));
  gh.lazySingleton<_i19.CategoryDao>(
      () => _i19.CategoryDao(get<_i20.CategoriesDatabase>()));
  gh.lazySingleton<_i21.CategoryMapper>(() => _i21.CategoryMapper());
  gh.lazySingleton<_i22.CategoryRepository>(
      () => _i23.CategoryRepositoryImpl(get<_i16.CategoriesLocalDataSource>()));
  gh.factory<_i24.CreateAccount>(
      () => _i24.CreateAccount(get<_i6.AccountRepository>()));
  gh.factory<_i25.CreateCategory>(
      () => _i25.CreateCategory(get<_i22.CategoryRepository>()));
  gh.factory<_i26.DeleteAccount>(
      () => _i26.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i27.DeleteCategory>(
      () => _i27.DeleteCategory(get<_i22.CategoryRepository>()));
  gh.factory<_i28.EditAccountScreenCubit>(() => _i28.EditAccountScreenCubit(
      get<_i11.UpdateAccount>(),
      get<_i11.DeleteAccount>(),
      get<_i12.GetProfileInfo>(),
      get<_i11.CreateAccount>()));
  gh.factory<_i29.EditCategoryScreenCubit>(() => _i29.EditCategoryScreenCubit(
      get<_i14.UpdateCategory>(),
      get<_i14.DeleteCategory>(),
      get<_i12.GetProfileInfo>(),
      get<_i14.GetSubCategories>(),
      get<_i14.SaveSubCategories>(),
      get<_i14.CreateSubCategory>(),
      get<_i14.CreateCategory>()));
  gh.factory<_i30.EditSubCategoryScreenCubit>(() =>
      _i30.EditSubCategoryScreenCubit(
          get<_i14.UpdateSubCategory>(), get<_i14.DeleteSubCategory>()));
  gh.lazySingleton<_i31.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i32.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i33.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i34.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i35.GetAccounts>(
      () => _i35.GetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i36.GetCategories>(
      () => _i36.GetCategories(get<_i22.CategoryRepository>()));
  gh.lazySingleton<_i37.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i38.HomeScreenCubit>(
      () => _i38.HomeScreenCubit(get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i39.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i40.PickUserImage>(
      () => _i40.PickUserImage(get<_i39.ImagePicker>()));
  gh.factory<_i41.ProfileScreenCubit>(() => _i41.ProfileScreenCubit(
      get<_i12.CheckAuthStatus>(),
      get<_i12.GetProfileInfo>(),
      get<_i12.UpdateUserInfo>(),
      get<_i12.PickUserImage>()));
  gh.factory<_i42.RecordCubit>(
      () => _i42.RecordCubit(get<_i43.RecordRepositoryBase>()));
  gh.factory<_i44.SaveAccounts>(
      () => _i44.SaveAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i45.SaveCategories>(
      () => _i45.SaveCategories(get<_i22.CategoryRepository>()));
  gh.factory<_i46.SettingsScreenCubit>(() => _i46.SettingsScreenCubit(
      get<_i12.CheckAuthStatus>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i47.SubCategoriesScreenCubit>(() => _i47.SubCategoriesScreenCubit(
      get<_i14.GetSubCategories>(), get<_i14.SaveSubCategories>()));
  gh.lazySingleton<_i19.SubCategoryDao>(
      () => _i19.SubCategoryDao(get<_i20.CategoriesDatabase>()));
  gh.lazySingleton<_i48.SubCategoryMapper>(() => _i48.SubCategoryMapper());
  gh.lazySingleton<_i22.SubCategoryRepository>(() =>
      _i49.SubCategoryRepositoryImpl(get<_i16.CategoriesLocalDataSource>()));
  gh.factory<_i50.UpdateAccount>(() => _i50.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i35.GetAccounts>()));
  gh.factory<_i51.UpdateCategory>(() => _i51.UpdateCategory(
      get<_i22.CategoryRepository>(), get<_i14.GetCategories>()));
  gh.factory<_i52.UpdateSubCategory>(() => _i52.UpdateSubCategory(
      get<_i22.SubCategoryRepository>(), get<_i14.GetSubCategories>()));
  gh.lazySingleton<_i53.UserFirebaseProv>(() => _i53.UserFirebaseProv(
      get<_i34.FirebaseStorage>(), get<_i33.FirebaseFirestore>()));
  gh.lazySingleton<_i54.AuthService>(() => _i55.AuthServiceImpl(
      get<_i32.FirebaseAuth>(),
      get<_i37.GoogleSignIn>(),
      get<_i31.FacebookAuth>(),
      get<_i53.UserFirebaseProv>()));
  gh.factory<_i56.CheckAuthStatus>(
      () => _i56.CheckAuthStatus(get<_i54.AuthService>()));
  gh.factory<_i57.CreateSubCategory>(
      () => _i57.CreateSubCategory(get<_i22.SubCategoryRepository>()));
  gh.factory<_i58.CreateUser>(() => _i58.CreateUser(get<_i54.AuthService>()));
  gh.factory<_i59.DeleteSubCategory>(
      () => _i59.DeleteSubCategory(get<_i22.SubCategoryRepository>()));
  gh.factory<_i60.GetProfileInfo>(
      () => _i60.GetProfileInfo(get<_i54.AuthService>()));
  gh.factory<_i61.GetSubCategories>(
      () => _i61.GetSubCategories(get<_i22.SubCategoryRepository>()));
  gh.factory<_i62.LogOut>(() => _i62.LogOut(get<_i54.AuthService>()));
  gh.factory<_i63.SaveSubCategories>(
      () => _i63.SaveSubCategories(get<_i22.SubCategoryRepository>()));
  gh.factory<_i64.SignIn>(() => _i64.SignIn(get<_i54.AuthService>()));
  gh.factory<_i65.UpdateUserInfo>(
      () => _i65.UpdateUserInfo(get<_i54.AuthService>()));
  return get;
}

class _$DbInjectableModule extends _i66.DbInjectableModule {}

class _$FacebookInjectableModule extends _i67.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i68.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i69.ImagePickerInjectableModule {}

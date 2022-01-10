// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i42;
import 'package:firebase_auth/firebase_auth.dart' as _i41;
import 'package:firebase_storage/firebase_storage.dart' as _i43;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i40;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i47;
import 'package:image_picker/image_picker.dart' as _i49;
import 'package:injectable/injectable.dart' as _i2;

import '../core/accounts/application.dart' as _i11;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/create_account.dart' as _i31;
import '../core/accounts/src/application/delete_account.dart' as _i34;
import '../core/accounts/src/application/get_accounts.dart' as _i44;
import '../core/accounts/src/application/save_accounts.dart' as _i54;
import '../core/accounts/src/application/update_account.dart' as _i61;
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
import '../core/budgets/application.dart' as _i63;
import '../core/budgets/domain.dart' as _i19;
import '../core/budgets/infrastructure.dart' as _i21;
import '../core/budgets/src/application/create_budget.dart' as _i32;
import '../core/budgets/src/application/delete_budget.dart' as _i35;
import '../core/budgets/src/application/get_budgets.dart' as _i45;
import '../core/budgets/src/application/save_budgets.dart' as _i55;
import '../core/budgets/src/application/update_budget.dart' as _i62;
import '../core/budgets/src/infrastructure/budget_repository_impl.dart' as _i20;
import '../core/budgets/src/infrastructure/datasources/local/budget_mapper.dart'
    as _i18;
import '../core/budgets/src/infrastructure/datasources/local/budgets_db.dart'
    as _i17;
import '../core/budgets/src/infrastructure/datasources/local/budgets_local_data_source.dart'
    as _i22;
import '../core/budgets/src/infrastructure/datasources/local/budgets_table.dart'
    as _i16;
import '../core/categories/application.dart' as _i14;
import '../core/categories/domain.dart' as _i29;
import '../core/categories/infrastructure.dart' as _i23;
import '../core/categories/src/application/create_category.dart' as _i33;
import '../core/categories/src/application/create_sub_category.dart' as _i70;
import '../core/categories/src/application/delete_category.dart' as _i36;
import '../core/categories/src/application/delete_sub_category.dart' as _i72;
import '../core/categories/src/application/get_categories.dart' as _i46;
import '../core/categories/src/application/get_sub_categories.dart' as _i74;
import '../core/categories/src/application/save_categories.dart' as _i56;
import '../core/categories/src/application/save_sub_categories.dart' as _i76;
import '../core/categories/src/application/update_category.dart' as _i64;
import '../core/categories/src/application/update_sub_category.dart' as _i65;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i30;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i27;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i24;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i26;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i28;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i59;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i60;
import '../core/records/domain.dart' as _i53;
import '../core/records/src/application/record_cubit.dart' as _i52;
import '../core/user/application.dart' as _i12;
import '../core/user/domain.dart' as _i67;
import '../core/user/src/application/check_auth_status.dart' as _i69;
import '../core/user/src/application/create_user.dart' as _i71;
import '../core/user/src/application/get_profile_info.dart' as _i73;
import '../core/user/src/application/log_out.dart' as _i75;
import '../core/user/src/application/pick_user_image.dart' as _i50;
import '../core/user/src/application/sign_in.dart' as _i77;
import '../core/user/src/application/update_user_info.dart' as _i78;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i68;
import '../core/user/src/infrastructure/auth/user_firebase_prov.dart' as _i66;
import '../presentation/core/auth/auth_cubit.dart' as _i13;
import '../presentation/screens/accounts/accounts_cubit/accounts_screen_cubit.dart'
    as _i10;
import '../presentation/screens/accounts/edit_account_cubit/edit_account_screen_cubit.dart'
    as _i37;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i15;
import '../presentation/screens/categories/categories_cubit/categories_screen_cubit.dart'
    as _i25;
import '../presentation/screens/categories/edit_category_cubit/edit_category_screen_cubit.dart'
    as _i38;
import '../presentation/screens/categories/edit_sub_category_cubit/edit_sub_category_screen_cubit.dart'
    as _i39;
import '../presentation/screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart'
    as _i58;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i48;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i51;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i57;
import 'db_injectable_module.dart' as _i79;
import 'facebook_injectable_module.dart' as _i80;
import 'firebase_injectable_module.dart' as _i81;
import 'image_picker_injectable_module.dart'
    as _i82; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i16.BudgetDao>(
      () => _i16.BudgetDao(get<_i17.BudgetsDatabase>()));
  gh.lazySingleton<_i18.BudgetMapper>(() => _i18.BudgetMapper());
  gh.lazySingleton<_i19.BudgetRepository>(
      () => _i20.BudgetRepositoryImpl(get<_i21.BudgetsLocalDataSource>()));
  gh.lazySingleton<_i22.BudgetsLocalDataSource>(() =>
      _i22.BudgetsLocalDataSourceImpl(
          get<_i21.BudgetDao>(), get<_i21.BudgetMapper>()));
  gh.lazySingleton<_i23.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i24.CategoriesLocalDataSource>(() =>
      _i24.CategoriesLocalDataSourceImpl(
          get<_i23.CategoryDao>(),
          get<_i23.SubCategoryDao>(),
          get<_i23.CategoryMapper>(),
          get<_i23.SubCategoryMapper>()));
  gh.factory<_i25.CategoriesScreenCubit>(() => _i25.CategoriesScreenCubit(
      get<_i14.GetCategories>(),
      get<_i12.GetProfileInfo>(),
      get<_i14.CreateCategory>(),
      get<_i14.SaveCategories>()));
  gh.lazySingleton<_i26.CategoryDao>(
      () => _i26.CategoryDao(get<_i27.CategoriesDatabase>()));
  gh.lazySingleton<_i28.CategoryMapper>(() => _i28.CategoryMapper());
  gh.lazySingleton<_i29.CategoryRepository>(
      () => _i30.CategoryRepositoryImpl(get<_i23.CategoriesLocalDataSource>()));
  gh.factory<_i31.CreateAccount>(
      () => _i31.CreateAccount(get<_i6.AccountRepository>()));
  gh.factory<_i32.CreateBudget>(
      () => _i32.CreateBudget(get<_i19.BudgetRepository>()));
  gh.factory<_i33.CreateCategory>(
      () => _i33.CreateCategory(get<_i29.CategoryRepository>()));
  gh.factory<_i34.DeleteAccount>(
      () => _i34.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i35.DeleteBudget>(
      () => _i35.DeleteBudget(get<_i19.BudgetRepository>()));
  gh.factory<_i36.DeleteCategory>(
      () => _i36.DeleteCategory(get<_i29.CategoryRepository>()));
  gh.factory<_i37.EditAccountScreenCubit>(() => _i37.EditAccountScreenCubit(
      get<_i11.UpdateAccount>(),
      get<_i11.DeleteAccount>(),
      get<_i12.GetProfileInfo>(),
      get<_i11.CreateAccount>()));
  gh.factory<_i38.EditCategoryScreenCubit>(() => _i38.EditCategoryScreenCubit(
      get<_i14.UpdateCategory>(),
      get<_i14.DeleteCategory>(),
      get<_i12.GetProfileInfo>(),
      get<_i14.GetSubCategories>(),
      get<_i14.SaveSubCategories>(),
      get<_i14.CreateSubCategory>(),
      get<_i14.CreateCategory>()));
  gh.factory<_i39.EditSubCategoryScreenCubit>(() =>
      _i39.EditSubCategoryScreenCubit(
          get<_i14.UpdateSubCategory>(), get<_i14.DeleteSubCategory>()));
  gh.lazySingleton<_i40.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i41.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i42.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i43.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i44.GetAccounts>(
      () => _i44.GetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i45.GetBudgets>(
      () => _i45.GetBudgets(get<_i19.BudgetRepository>()));
  gh.factory<_i46.GetCategories>(
      () => _i46.GetCategories(get<_i29.CategoryRepository>()));
  gh.lazySingleton<_i47.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i48.HomeScreenCubit>(
      () => _i48.HomeScreenCubit(get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i49.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i50.PickUserImage>(
      () => _i50.PickUserImage(get<_i49.ImagePicker>()));
  gh.factory<_i51.ProfileScreenCubit>(() => _i51.ProfileScreenCubit(
      get<_i12.CheckAuthStatus>(),
      get<_i12.GetProfileInfo>(),
      get<_i12.UpdateUserInfo>(),
      get<_i12.PickUserImage>()));
  gh.factory<_i52.RecordCubit>(
      () => _i52.RecordCubit(get<_i53.RecordRepositoryBase>()));
  gh.factory<_i54.SaveAccounts>(
      () => _i54.SaveAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i55.SaveBudgets>(
      () => _i55.SaveBudgets(get<_i19.BudgetRepository>()));
  gh.factory<_i56.SaveCategories>(
      () => _i56.SaveCategories(get<_i29.CategoryRepository>()));
  gh.factory<_i57.SettingsScreenCubit>(() => _i57.SettingsScreenCubit(
      get<_i12.CheckAuthStatus>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i58.SubCategoriesScreenCubit>(() => _i58.SubCategoriesScreenCubit(
      get<_i14.GetSubCategories>(), get<_i14.SaveSubCategories>()));
  gh.lazySingleton<_i26.SubCategoryDao>(
      () => _i26.SubCategoryDao(get<_i27.CategoriesDatabase>()));
  gh.lazySingleton<_i59.SubCategoryMapper>(() => _i59.SubCategoryMapper());
  gh.lazySingleton<_i29.SubCategoryRepository>(() =>
      _i60.SubCategoryRepositoryImpl(get<_i23.CategoriesLocalDataSource>()));
  gh.factory<_i61.UpdateAccount>(() => _i61.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i44.GetAccounts>()));
  gh.factory<_i62.UpdateBudget>(() =>
      _i62.UpdateBudget(get<_i19.BudgetRepository>(), get<_i63.GetBudgets>()));
  gh.factory<_i64.UpdateCategory>(() => _i64.UpdateCategory(
      get<_i29.CategoryRepository>(), get<_i14.GetCategories>()));
  gh.factory<_i65.UpdateSubCategory>(() => _i65.UpdateSubCategory(
      get<_i29.SubCategoryRepository>(), get<_i14.GetSubCategories>()));
  gh.lazySingleton<_i66.UserFirebaseProv>(() => _i66.UserFirebaseProv(
      get<_i43.FirebaseStorage>(), get<_i42.FirebaseFirestore>()));
  gh.lazySingleton<_i67.AuthService>(() => _i68.AuthServiceImpl(
      get<_i41.FirebaseAuth>(),
      get<_i47.GoogleSignIn>(),
      get<_i40.FacebookAuth>(),
      get<_i66.UserFirebaseProv>()));
  gh.factory<_i69.CheckAuthStatus>(
      () => _i69.CheckAuthStatus(get<_i67.AuthService>()));
  gh.factory<_i70.CreateSubCategory>(
      () => _i70.CreateSubCategory(get<_i29.SubCategoryRepository>()));
  gh.factory<_i71.CreateUser>(() => _i71.CreateUser(get<_i67.AuthService>()));
  gh.factory<_i72.DeleteSubCategory>(
      () => _i72.DeleteSubCategory(get<_i29.SubCategoryRepository>()));
  gh.factory<_i73.GetProfileInfo>(
      () => _i73.GetProfileInfo(get<_i67.AuthService>()));
  gh.factory<_i74.GetSubCategories>(
      () => _i74.GetSubCategories(get<_i29.SubCategoryRepository>()));
  gh.factory<_i75.LogOut>(() => _i75.LogOut(get<_i67.AuthService>()));
  gh.factory<_i76.SaveSubCategories>(
      () => _i76.SaveSubCategories(get<_i29.SubCategoryRepository>()));
  gh.factory<_i77.SignIn>(() => _i77.SignIn(get<_i67.AuthService>()));
  gh.factory<_i78.UpdateUserInfo>(
      () => _i78.UpdateUserInfo(get<_i67.AuthService>()));
  return get;
}

class _$DbInjectableModule extends _i79.DbInjectableModule {}

class _$FacebookInjectableModule extends _i80.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i81.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i82.ImagePickerInjectableModule {}

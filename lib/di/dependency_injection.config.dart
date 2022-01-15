// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i47;
import 'package:firebase_auth/firebase_auth.dart' as _i46;
import 'package:firebase_storage/firebase_storage.dart' as _i48;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i45;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i52;
import 'package:image_picker/image_picker.dart' as _i54;
import 'package:injectable/injectable.dart' as _i2;

import '../core/accounts/application.dart' as _i11;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/create_account.dart' as _i33;
import '../core/accounts/src/application/delete_account.dart' as _i36;
import '../core/accounts/src/application/get_accounts.dart' as _i49;
import '../core/accounts/src/application/save_accounts.dart' as _i59;
import '../core/accounts/src/application/update_account.dart' as _i74;
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
import '../core/budgets/application.dart' as _i24;
import '../core/budgets/domain.dart' as _i19;
import '../core/budgets/infrastructure.dart' as _i21;
import '../core/budgets/src/application/create_budget.dart' as _i34;
import '../core/budgets/src/application/delete_budget.dart' as _i37;
import '../core/budgets/src/application/get_budgets.dart' as _i50;
import '../core/budgets/src/application/save_budgets.dart' as _i60;
import '../core/budgets/src/application/update_budget.dart' as _i75;
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
import '../core/categories/domain.dart' as _i31;
import '../core/categories/infrastructure.dart' as _i25;
import '../core/categories/src/application/create_category.dart' as _i35;
import '../core/categories/src/application/create_sub_category.dart' as _i84;
import '../core/categories/src/application/delete_category.dart' as _i38;
import '../core/categories/src/application/delete_sub_category.dart' as _i86;
import '../core/categories/src/application/get_categories.dart' as _i51;
import '../core/categories/src/application/get_sub_categories.dart' as _i89;
import '../core/categories/src/application/save_categories.dart' as _i61;
import '../core/categories/src/application/save_sub_categories.dart' as _i92;
import '../core/categories/src/application/update_category.dart' as _i76;
import '../core/categories/src/application/update_sub_category.dart' as _i77;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i32;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i29;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i26;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i28;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i30;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i64;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i65;
import '../core/records/domain.dart' as _i58;
import '../core/records/src/application/record_cubit.dart' as _i57;
import '../core/transactions/application.dart' as _i44;
import '../core/transactions/domain.dart' as _i69;
import '../core/transactions/infrastructure.dart' as _i71;
import '../core/transactions/src/application/add_transaction.dart' as _i80;
import '../core/transactions/src/application/delete_transaction.dart' as _i87;
import '../core/transactions/src/application/get_transactions.dart' as _i90;
import '../core/transactions/src/application/update_transaction.dart' as _i78;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i68;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i67;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i72;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i66;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i70;
import '../core/user/application.dart' as _i12;
import '../core/user/domain.dart' as _i81;
import '../core/user/src/application/check_auth_status.dart' as _i83;
import '../core/user/src/application/create_user.dart' as _i85;
import '../core/user/src/application/get_profile_info.dart' as _i88;
import '../core/user/src/application/log_out.dart' as _i91;
import '../core/user/src/application/pick_user_image.dart' as _i55;
import '../core/user/src/application/sign_in.dart' as _i93;
import '../core/user/src/application/update_user_info.dart' as _i94;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i82;
import '../core/user/src/infrastructure/auth/user_firebase_prov.dart' as _i79;
import '../presentation/core/auth/auth_cubit.dart' as _i13;
import '../presentation/screens/accounts/accounts_cubit/accounts_screen_cubit.dart'
    as _i10;
import '../presentation/screens/accounts/edit_account_cubit/edit_account_screen_cubit.dart'
    as _i39;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i15;
import '../presentation/screens/budgets/budgets_cubit/butgets_screen_cubit.dart'
    as _i23;
import '../presentation/screens/budgets/edit_budget_cubit/edit_budget_screen_cubit.dart'
    as _i40;
import '../presentation/screens/categories/categories_cubit/categories_screen_cubit.dart'
    as _i27;
import '../presentation/screens/categories/edit_category_cubit/edit_category_screen_cubit.dart'
    as _i41;
import '../presentation/screens/categories/edit_sub_category_cubit/edit_sub_category_screen_cubit.dart'
    as _i42;
import '../presentation/screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart'
    as _i63;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i53;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i56;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i62;
import '../presentation/screens/transactions/edit_transaction_cubit/edit_transaction_screen_cubit.dart'
    as _i43;
import '../presentation/screens/transactions/transactions_cubit/transactions_screen_cubit.dart'
    as _i73;
import 'db_injectable_module.dart' as _i95;
import 'facebook_injectable_module.dart' as _i96;
import 'firebase_injectable_module.dart' as _i97;
import 'image_picker_injectable_module.dart'
    as _i98; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i21.BudgetsDatabase>(
      () => dbInjectableModule.budgetsDatabase);
  gh.lazySingleton<_i22.BudgetsLocalDataSource>(() =>
      _i22.BudgetsLocalDataSourceImpl(
          get<_i21.BudgetDao>(), get<_i21.BudgetMapper>()));
  gh.factory<_i23.BudgetsScreenCubit>(() => _i23.BudgetsScreenCubit(
      get<_i24.GetBudgets>(),
      get<_i12.GetProfileInfo>(),
      get<_i24.CreateBudget>(),
      get<_i24.SaveBudgets>()));
  gh.lazySingleton<_i25.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i26.CategoriesLocalDataSource>(() =>
      _i26.CategoriesLocalDataSourceImpl(
          get<_i25.CategoryDao>(),
          get<_i25.SubCategoryDao>(),
          get<_i25.CategoryMapper>(),
          get<_i25.SubCategoryMapper>()));
  gh.factory<_i27.CategoriesScreenCubit>(() => _i27.CategoriesScreenCubit(
      get<_i14.GetCategories>(),
      get<_i12.GetProfileInfo>(),
      get<_i14.CreateCategory>(),
      get<_i14.SaveCategories>()));
  gh.lazySingleton<_i28.CategoryDao>(
      () => _i28.CategoryDao(get<_i29.CategoriesDatabase>()));
  gh.lazySingleton<_i30.CategoryMapper>(() => _i30.CategoryMapper());
  gh.lazySingleton<_i31.CategoryRepository>(
      () => _i32.CategoryRepositoryImpl(get<_i25.CategoriesLocalDataSource>()));
  gh.factory<_i33.CreateAccount>(
      () => _i33.CreateAccount(get<_i6.AccountRepository>()));
  gh.factory<_i34.CreateBudget>(
      () => _i34.CreateBudget(get<_i19.BudgetRepository>()));
  gh.factory<_i35.CreateCategory>(
      () => _i35.CreateCategory(get<_i31.CategoryRepository>()));
  gh.factory<_i36.DeleteAccount>(
      () => _i36.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i37.DeleteBudget>(
      () => _i37.DeleteBudget(get<_i19.BudgetRepository>()));
  gh.factory<_i38.DeleteCategory>(
      () => _i38.DeleteCategory(get<_i31.CategoryRepository>()));
  gh.factory<_i39.EditAccountScreenCubit>(() => _i39.EditAccountScreenCubit(
      get<_i11.UpdateAccount>(),
      get<_i11.DeleteAccount>(),
      get<_i12.GetProfileInfo>(),
      get<_i11.CreateAccount>()));
  gh.factory<_i40.EditBudgetScreenCubit>(() => _i40.EditBudgetScreenCubit(
      get<_i24.UpdateBudget>(),
      get<_i24.DeleteBudget>(),
      get<_i12.GetProfileInfo>(),
      get<_i24.CreateBudget>()));
  gh.factory<_i41.EditCategoryScreenCubit>(() => _i41.EditCategoryScreenCubit(
      get<_i14.UpdateCategory>(),
      get<_i14.DeleteCategory>(),
      get<_i12.GetProfileInfo>(),
      get<_i14.GetSubCategories>(),
      get<_i14.SaveSubCategories>(),
      get<_i14.CreateSubCategory>(),
      get<_i14.CreateCategory>()));
  gh.factory<_i42.EditSubCategoryScreenCubit>(() =>
      _i42.EditSubCategoryScreenCubit(
          get<_i14.UpdateSubCategory>(), get<_i14.DeleteSubCategory>()));
  gh.factory<_i43.EditTransactionScreenCubit>(() =>
      _i43.EditTransactionScreenCubit(
          get<_i44.UpdateTransaction>(),
          get<_i44.DeleteTransaction>(),
          get<_i12.GetProfileInfo>(),
          get<_i44.AddTransaction>(),
          get<_i11.GetAccounts>(),
          get<_i24.GetBudgets>(),
          get<_i14.GetCategories>(),
          get<_i14.SaveCategories>(),
          get<_i14.GetSubCategories>(),
          get<_i14.SaveSubCategories>()));
  gh.lazySingleton<_i45.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i46.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i47.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i48.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i49.GetAccounts>(
      () => _i49.GetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i50.GetBudgets>(
      () => _i50.GetBudgets(get<_i19.BudgetRepository>()));
  gh.factory<_i51.GetCategories>(
      () => _i51.GetCategories(get<_i31.CategoryRepository>()));
  gh.lazySingleton<_i52.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i53.HomeScreenCubit>(
      () => _i53.HomeScreenCubit(get<_i12.GetProfileInfo>()));
  gh.lazySingleton<_i54.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i55.PickUserImage>(
      () => _i55.PickUserImage(get<_i54.ImagePicker>()));
  gh.factory<_i56.ProfileScreenCubit>(() => _i56.ProfileScreenCubit(
      get<_i12.CheckAuthStatus>(),
      get<_i12.GetProfileInfo>(),
      get<_i12.UpdateUserInfo>(),
      get<_i12.PickUserImage>()));
  gh.factory<_i57.RecordCubit>(
      () => _i57.RecordCubit(get<_i58.RecordRepositoryBase>()));
  gh.factory<_i59.SaveAccounts>(
      () => _i59.SaveAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i60.SaveBudgets>(
      () => _i60.SaveBudgets(get<_i19.BudgetRepository>()));
  gh.factory<_i61.SaveCategories>(
      () => _i61.SaveCategories(get<_i31.CategoryRepository>()));
  gh.factory<_i62.SettingsScreenCubit>(() => _i62.SettingsScreenCubit(
      get<_i12.CheckAuthStatus>(), get<_i12.GetProfileInfo>()));
  gh.factory<_i63.SubCategoriesScreenCubit>(() => _i63.SubCategoriesScreenCubit(
      get<_i14.GetSubCategories>(), get<_i14.SaveSubCategories>()));
  gh.lazySingleton<_i28.SubCategoryDao>(
      () => _i28.SubCategoryDao(get<_i29.CategoriesDatabase>()));
  gh.lazySingleton<_i64.SubCategoryMapper>(() => _i64.SubCategoryMapper());
  gh.lazySingleton<_i31.SubCategoryRepository>(() =>
      _i65.SubCategoryRepositoryImpl(get<_i25.CategoriesLocalDataSource>()));
  gh.lazySingleton<_i66.TransactionDao>(
      () => _i66.TransactionDao(get<_i67.TransactionsDatabase>()));
  gh.lazySingleton<_i68.TransactionMapper>(() => _i68.TransactionMapper());
  gh.lazySingleton<_i69.TransactionRepository>(() =>
      _i70.TransactionRepositoryImpl(get<_i71.TransactionsLocalDataSource>()));
  gh.lazySingleton<_i71.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i72.TransactionsLocalDataSource>(() =>
      _i72.TransactionsLocalDataSourceImpl(
          get<_i71.TransactionDao>(), get<_i71.TransactionMapper>()));
  gh.factory<_i73.TransactionsScreenCubit>(() => _i73.TransactionsScreenCubit(
      get<_i44.GetTransactions>(),
      get<_i12.GetProfileInfo>(),
      get<_i44.AddTransaction>()));
  gh.factory<_i74.UpdateAccount>(() => _i74.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i49.GetAccounts>()));
  gh.factory<_i75.UpdateBudget>(() =>
      _i75.UpdateBudget(get<_i19.BudgetRepository>(), get<_i24.GetBudgets>()));
  gh.factory<_i76.UpdateCategory>(() => _i76.UpdateCategory(
      get<_i31.CategoryRepository>(), get<_i14.GetCategories>()));
  gh.factory<_i77.UpdateSubCategory>(() => _i77.UpdateSubCategory(
      get<_i31.SubCategoryRepository>(), get<_i14.GetSubCategories>()));
  gh.factory<_i78.UpdateTransaction>(() => _i78.UpdateTransaction(
      get<_i69.TransactionRepository>(), get<_i44.GetTransactions>()));
  gh.lazySingleton<_i79.UserFirebaseProv>(() => _i79.UserFirebaseProv(
      get<_i48.FirebaseStorage>(), get<_i47.FirebaseFirestore>()));
  gh.factory<_i80.AddTransaction>(
      () => _i80.AddTransaction(get<_i69.TransactionRepository>()));
  gh.lazySingleton<_i81.AuthService>(() => _i82.AuthServiceImpl(
      get<_i46.FirebaseAuth>(),
      get<_i52.GoogleSignIn>(),
      get<_i45.FacebookAuth>(),
      get<_i79.UserFirebaseProv>()));
  gh.factory<_i83.CheckAuthStatus>(
      () => _i83.CheckAuthStatus(get<_i81.AuthService>()));
  gh.factory<_i84.CreateSubCategory>(
      () => _i84.CreateSubCategory(get<_i31.SubCategoryRepository>()));
  gh.factory<_i85.CreateUser>(() => _i85.CreateUser(get<_i81.AuthService>()));
  gh.factory<_i86.DeleteSubCategory>(
      () => _i86.DeleteSubCategory(get<_i31.SubCategoryRepository>()));
  gh.factory<_i87.DeleteTransaction>(
      () => _i87.DeleteTransaction(get<_i69.TransactionRepository>()));
  gh.factory<_i88.GetProfileInfo>(
      () => _i88.GetProfileInfo(get<_i81.AuthService>()));
  gh.factory<_i89.GetSubCategories>(
      () => _i89.GetSubCategories(get<_i31.SubCategoryRepository>()));
  gh.factory<_i90.GetTransactions>(
      () => _i90.GetTransactions(get<_i69.TransactionRepository>()));
  gh.factory<_i91.LogOut>(() => _i91.LogOut(get<_i81.AuthService>()));
  gh.factory<_i92.SaveSubCategories>(
      () => _i92.SaveSubCategories(get<_i31.SubCategoryRepository>()));
  gh.factory<_i93.SignIn>(() => _i93.SignIn(get<_i81.AuthService>()));
  gh.factory<_i94.UpdateUserInfo>(
      () => _i94.UpdateUserInfo(get<_i81.AuthService>()));
  return get;
}

class _$DbInjectableModule extends _i95.DbInjectableModule {}

class _$FacebookInjectableModule extends _i96.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i97.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i98.ImagePickerInjectableModule {}

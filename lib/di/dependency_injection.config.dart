// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i45;
import 'package:firebase_auth/firebase_auth.dart' as _i44;
import 'package:firebase_storage/firebase_storage.dart' as _i46;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i43;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i50;
import 'package:image_picker/image_picker.dart' as _i52;
import 'package:injectable/injectable.dart' as _i2;

import '../core/accounts/application.dart' as _i35;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/create_account.dart' as _i27;
import '../core/accounts/src/application/delete_account.dart' as _i31;
import '../core/accounts/src/application/get_accounts.dart' as _i47;
import '../core/accounts/src/application/set_default_accounts.dart' as _i58;
import '../core/accounts/src/application/update_account.dart' as _i73;
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
import '../core/budgets/application.dart' as _i37;
import '../core/budgets/domain.dart' as _i16;
import '../core/budgets/infrastructure.dart' as _i18;
import '../core/budgets/src/application/create_budget.dart' as _i28;
import '../core/budgets/src/application/delete_budget.dart' as _i32;
import '../core/budgets/src/application/get_budgets.dart' as _i48;
import '../core/budgets/src/application/set_default_budgets.dart' as _i59;
import '../core/budgets/src/application/update_budget.dart' as _i74;
import '../core/budgets/src/infrastructure/budget_repository_impl.dart' as _i17;
import '../core/budgets/src/infrastructure/datasources/local/budget_mapper.dart'
    as _i15;
import '../core/budgets/src/infrastructure/datasources/local/budgets_db.dart'
    as _i14;
import '../core/budgets/src/infrastructure/datasources/local/budgets_local_data_source.dart'
    as _i19;
import '../core/budgets/src/infrastructure/datasources/local/budgets_table.dart'
    as _i13;
import '../core/categories/application.dart' as _i39;
import '../core/categories/domain.dart' as _i25;
import '../core/categories/infrastructure.dart' as _i20;
import '../core/categories/src/application/create_category.dart' as _i29;
import '../core/categories/src/application/create_sub_category.dart' as _i83;
import '../core/categories/src/application/delete_category.dart' as _i33;
import '../core/categories/src/application/delete_sub_category.dart' as _i85;
import '../core/categories/src/application/get_categories.dart' as _i49;
import '../core/categories/src/application/get_sub_categories.dart' as _i88;
import '../core/categories/src/application/set_default_categories.dart' as _i60;
import '../core/categories/src/application/set_default_sub_categories.dart'
    as _i91;
import '../core/categories/src/application/update_category.dart' as _i75;
import '../core/categories/src/application/update_sub_category.dart' as _i76;
import '../core/categories/src/infrastructure/category_repository_impl.dart'
    as _i26;
import '../core/categories/src/infrastructure/datasources/local/categories_db.dart'
    as _i23;
import '../core/categories/src/infrastructure/datasources/local/categories_local_data_source.dart'
    as _i21;
import '../core/categories/src/infrastructure/datasources/local/categories_table.dart'
    as _i22;
import '../core/categories/src/infrastructure/datasources/local/category_mapper.dart'
    as _i24;
import '../core/categories/src/infrastructure/datasources/local/sub_category_mapper.dart'
    as _i63;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i64;
import '../core/records/domain.dart' as _i57;
import '../core/records/src/application/record_cubit.dart' as _i56;
import '../core/transactions/application.dart' as _i42;
import '../core/transactions/domain.dart' as _i68;
import '../core/transactions/infrastructure.dart' as _i70;
import '../core/transactions/src/application/add_transaction.dart' as _i79;
import '../core/transactions/src/application/delete_transaction.dart' as _i86;
import '../core/transactions/src/application/get_transactions.dart' as _i89;
import '../core/transactions/src/application/update_transaction.dart' as _i77;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i67;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i66;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i71;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i65;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i69;
import '../core/user/application.dart' as _i11;
import '../core/user/domain.dart' as _i80;
import '../core/user/src/application/check_auth_status.dart' as _i82;
import '../core/user/src/application/create_user.dart' as _i84;
import '../core/user/src/application/get_profile_info.dart' as _i87;
import '../core/user/src/application/log_out.dart' as _i90;
import '../core/user/src/application/pick_user_image.dart' as _i54;
import '../core/user/src/application/sign_in.dart' as _i92;
import '../core/user/src/application/update_user_info.dart' as _i93;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i81;
import '../core/user/src/infrastructure/auth/user_firebase_prov.dart' as _i78;
import '../presentation/core/auth/auth_bloc.dart' as _i10;
import '../presentation/core/date/date_bloc.dart' as _i30;
import '../presentation/core/settings/settings_bloc.dart' as _i61;
import '../presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart'
    as _i34;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i12;
import '../presentation/screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart'
    as _i36;
import '../presentation/screens/categories/edit_category_bloc/edit_category_screen_bloc.dart'
    as _i38;
import '../presentation/screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart'
    as _i40;
import '../presentation/screens/home/home_bloc/home_screen_bloc.dart' as _i51;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i55;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i62;
import '../presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart'
    as _i41;
import '../presentation/screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart'
    as _i53;
import '../presentation/screens/transactions/transactions_bloc/transactions_screen_bloc.dart'
    as _i72;
import 'db_injectable_module.dart' as _i94;
import 'facebook_injectable_module.dart' as _i95;
import 'firebase_injectable_module.dart' as _i96;
import 'image_picker_injectable_module.dart'
    as _i97; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i10.AuthBloc>(
      () => _i10.AuthBloc(get<_i11.CheckAuthStatus>(), get<_i11.LogOut>()));
  gh.factory<_i12.AuthScreenCubit>(() => _i12.AuthScreenCubit(
      get<_i11.SignIn>(), get<_i11.CreateUser>(), get<_i11.CheckAuthStatus>()));
  gh.lazySingleton<_i13.BudgetDao>(
      () => _i13.BudgetDao(get<_i14.BudgetsDatabase>()));
  gh.lazySingleton<_i15.BudgetMapper>(() => _i15.BudgetMapper());
  gh.lazySingleton<_i16.BudgetRepository>(
      () => _i17.BudgetRepositoryImpl(get<_i18.BudgetsLocalDataSource>()));
  gh.lazySingleton<_i18.BudgetsDatabase>(
      () => dbInjectableModule.budgetsDatabase);
  gh.lazySingleton<_i19.BudgetsLocalDataSource>(() =>
      _i19.BudgetsLocalDataSourceImpl(
          get<_i18.BudgetDao>(), get<_i18.BudgetMapper>()));
  gh.lazySingleton<_i20.CategoriesDatabase>(
      () => dbInjectableModule.categoriesDatabase);
  gh.lazySingleton<_i21.CategoriesLocalDataSource>(() =>
      _i21.CategoriesLocalDataSourceImpl(
          get<_i20.CategoryDao>(),
          get<_i20.SubCategoryDao>(),
          get<_i20.CategoryMapper>(),
          get<_i20.SubCategoryMapper>()));
  gh.lazySingleton<_i22.CategoryDao>(
      () => _i22.CategoryDao(get<_i23.CategoriesDatabase>()));
  gh.lazySingleton<_i24.CategoryMapper>(() => _i24.CategoryMapper());
  gh.lazySingleton<_i25.CategoryRepository>(
      () => _i26.CategoryRepositoryImpl(get<_i20.CategoriesLocalDataSource>()));
  gh.factory<_i27.CreateAccount>(() => _i27.CreateAccount(
      get<_i6.AccountRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i28.CreateBudget>(() => _i28.CreateBudget(
      get<_i16.BudgetRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i29.CreateCategory>(() => _i29.CreateCategory(
      get<_i25.CategoryRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i30.DateBloc>(() => _i30.DateBloc());
  gh.factory<_i31.DeleteAccount>(
      () => _i31.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i32.DeleteBudget>(
      () => _i32.DeleteBudget(get<_i16.BudgetRepository>()));
  gh.factory<_i33.DeleteCategory>(
      () => _i33.DeleteCategory(get<_i25.CategoryRepository>()));
  gh.factory<_i34.EditAccountScreenBloc>(() => _i34.EditAccountScreenBloc(
      get<_i35.UpdateAccount>(),
      get<_i35.DeleteAccount>(),
      get<_i11.GetProfileInfo>(),
      get<_i35.CreateAccount>()));
  gh.factory<_i36.EditBudgetScreenBloc>(() => _i36.EditBudgetScreenBloc(
      get<_i37.UpdateBudget>(),
      get<_i37.DeleteBudget>(),
      get<_i37.CreateBudget>()));
  gh.factory<_i38.EditCategoryScreenBloc>(() => _i38.EditCategoryScreenBloc(
      get<_i39.UpdateCategory>(),
      get<_i39.UpdateSubCategory>(),
      get<_i39.DeleteCategory>(),
      get<_i39.GetSubCategories>(),
      get<_i39.SetDefaultSubCategories>(),
      get<_i39.CreateSubCategory>(),
      get<_i39.CreateCategory>()));
  gh.factory<_i40.EditSubCategoryScreenBloc>(() =>
      _i40.EditSubCategoryScreenBloc(
          get<_i39.UpdateSubCategory>(), get<_i39.DeleteSubCategory>()));
  gh.factory<_i41.EditTransactionScreenBloc>(() =>
      _i41.EditTransactionScreenBloc(
          get<_i42.UpdateTransaction>(),
          get<_i42.DeleteTransaction>(),
          get<_i42.AddTransaction>(),
          get<_i39.GetSubCategories>(),
          get<_i39.SetDefaultSubCategories>()));
  gh.lazySingleton<_i43.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i44.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i45.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i46.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i47.GetAccounts>(
      () => _i47.GetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i48.GetBudgets>(
      () => _i48.GetBudgets(get<_i16.BudgetRepository>()));
  gh.factory<_i49.GetCategories>(
      () => _i49.GetCategories(get<_i25.CategoryRepository>()));
  gh.lazySingleton<_i50.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i51.HomeScreenBloc>(() => _i51.HomeScreenBloc(
      get<_i11.GetProfileInfo>(), get<_i42.GetTransactions>()));
  gh.lazySingleton<_i52.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i53.ManageIncomeScreenBloc>(() => _i53.ManageIncomeScreenBloc(
      get<_i37.UpdateBudget>(), get<_i42.UpdateTransaction>()));
  gh.factory<_i54.PickUserImage>(
      () => _i54.PickUserImage(get<_i52.ImagePicker>()));
  gh.factory<_i55.ProfileScreenCubit>(() => _i55.ProfileScreenCubit(
      get<_i11.GetProfileInfo>(),
      get<_i11.UpdateUserInfo>(),
      get<_i11.PickUserImage>()));
  gh.factory<_i56.RecordCubit>(
      () => _i56.RecordCubit(get<_i57.RecordRepositoryBase>()));
  gh.factory<_i58.SetDefaultAccounts>(() => _i58.SetDefaultAccounts(
      get<_i11.GetProfileInfo>(), get<_i6.AccountRepository>()));
  gh.factory<_i59.SetDefaultBudgets>(() => _i59.SetDefaultBudgets(
      get<_i16.BudgetRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i60.SetDefaultCategories>(() => _i60.SetDefaultCategories(
      get<_i11.GetProfileInfo>(), get<_i25.CategoryRepository>()));
  gh.factory<_i61.SettingsBloc>(() => _i61.SettingsBloc(
      get<_i11.GetProfileInfo>(),
      get<_i35.GetAccounts>(),
      get<_i35.SetDefaultAccounts>(),
      get<_i39.GetCategories>(),
      get<_i39.SetDefaultCategories>(),
      get<_i37.GetBudgets>(),
      get<_i37.SetDefaultBudgets>(),
      get<_i39.SetDefaultSubCategories>()));
  gh.factory<_i62.SettingsScreenCubit>(() => _i62.SettingsScreenCubit(
      get<_i11.CheckAuthStatus>(), get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i22.SubCategoryDao>(
      () => _i22.SubCategoryDao(get<_i23.CategoriesDatabase>()));
  gh.lazySingleton<_i63.SubCategoryMapper>(() => _i63.SubCategoryMapper());
  gh.lazySingleton<_i25.SubCategoryRepository>(() =>
      _i64.SubCategoryRepositoryImpl(get<_i20.CategoriesLocalDataSource>()));
  gh.lazySingleton<_i65.TransactionDao>(
      () => _i65.TransactionDao(get<_i66.TransactionsDatabase>()));
  gh.lazySingleton<_i67.TransactionMapper>(() => _i67.TransactionMapper());
  gh.lazySingleton<_i68.TransactionRepository>(() =>
      _i69.TransactionRepositoryImpl(get<_i70.TransactionsLocalDataSource>()));
  gh.lazySingleton<_i70.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i71.TransactionsLocalDataSource>(() =>
      _i71.TransactionsLocalDataSourceImpl(
          get<_i70.TransactionDao>(), get<_i70.TransactionMapper>()));
  gh.factory<_i72.TransactionsScreenBloc>(() => _i72.TransactionsScreenBloc(
      get<_i42.GetTransactions>(), get<_i42.DeleteTransaction>()));
  gh.factory<_i73.UpdateAccount>(() => _i73.UpdateAccount(
      get<_i6.AccountRepository>(),
      get<_i47.GetAccounts>(),
      get<_i11.GetProfileInfo>()));
  gh.factory<_i74.UpdateBudget>(() => _i74.UpdateBudget(
      get<_i16.BudgetRepository>(),
      get<_i37.GetBudgets>(),
      get<_i11.GetProfileInfo>()));
  gh.factory<_i75.UpdateCategory>(() => _i75.UpdateCategory(
      get<_i25.CategoryRepository>(),
      get<_i39.GetCategories>(),
      get<_i11.GetProfileInfo>()));
  gh.factory<_i76.UpdateSubCategory>(() => _i76.UpdateSubCategory(
      get<_i25.SubCategoryRepository>(), get<_i39.GetSubCategories>()));
  gh.factory<_i77.UpdateTransaction>(() => _i77.UpdateTransaction(
      get<_i68.TransactionRepository>(), get<_i42.GetTransactions>()));
  gh.lazySingleton<_i78.UserFirebaseProv>(() => _i78.UserFirebaseProv(
      get<_i46.FirebaseStorage>(), get<_i45.FirebaseFirestore>()));
  gh.factory<_i79.AddTransaction>(() => _i79.AddTransaction(
      get<_i68.TransactionRepository>(), get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i80.AuthService>(() => _i81.AuthServiceImpl(
      get<_i44.FirebaseAuth>(),
      get<_i50.GoogleSignIn>(),
      get<_i78.UserFirebaseProv>()));
  gh.factory<_i82.CheckAuthStatus>(
      () => _i82.CheckAuthStatus(get<_i80.AuthService>()));
  gh.factory<_i83.CreateSubCategory>(
      () => _i83.CreateSubCategory(get<_i25.SubCategoryRepository>()));
  gh.factory<_i84.CreateUser>(() => _i84.CreateUser(get<_i80.AuthService>()));
  gh.factory<_i85.DeleteSubCategory>(
      () => _i85.DeleteSubCategory(get<_i25.SubCategoryRepository>()));
  gh.factory<_i86.DeleteTransaction>(
      () => _i86.DeleteTransaction(get<_i68.TransactionRepository>()));
  gh.factory<_i87.GetProfileInfo>(
      () => _i87.GetProfileInfo(get<_i80.AuthService>()));
  gh.factory<_i88.GetSubCategories>(
      () => _i88.GetSubCategories(get<_i25.SubCategoryRepository>()));
  gh.factory<_i89.GetTransactions>(() => _i89.GetTransactions(
      get<_i68.TransactionRepository>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i90.LogOut>(() => _i90.LogOut(get<_i80.AuthService>()));
  gh.factory<_i91.SetDefaultSubCategories>(() => _i91.SetDefaultSubCategories(
      get<_i11.GetProfileInfo>(), get<_i25.SubCategoryRepository>()));
  gh.factory<_i92.SignIn>(() => _i92.SignIn(get<_i80.AuthService>()));
  gh.factory<_i93.UpdateUserInfo>(
      () => _i93.UpdateUserInfo(get<_i80.AuthService>()));
  return get;
}

class _$DbInjectableModule extends _i94.DbInjectableModule {}

class _$FacebookInjectableModule extends _i95.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i96.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i97.ImagePickerInjectableModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i44;
import 'package:firebase_auth/firebase_auth.dart' as _i43;
import 'package:firebase_storage/firebase_storage.dart' as _i45;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i42;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i49;
import 'package:image_picker/image_picker.dart' as _i51;
import 'package:injectable/injectable.dart' as _i2;

import '../core/accounts/application.dart' as _i34;
import '../core/accounts/domain.dart' as _i6;
import '../core/accounts/infrastructure.dart' as _i8;
import '../core/accounts/src/application/create_account.dart' as _i27;
import '../core/accounts/src/application/delete_account.dart' as _i30;
import '../core/accounts/src/application/get_accounts.dart' as _i46;
import '../core/accounts/src/application/save_accounts.dart' as _i56;
import '../core/accounts/src/application/update_account.dart' as _i71;
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
import '../core/budgets/application.dart' as _i36;
import '../core/budgets/domain.dart' as _i16;
import '../core/budgets/infrastructure.dart' as _i18;
import '../core/budgets/src/application/create_budget.dart' as _i28;
import '../core/budgets/src/application/delete_budget.dart' as _i31;
import '../core/budgets/src/application/get_budgets.dart' as _i47;
import '../core/budgets/src/application/save_budgets.dart' as _i57;
import '../core/budgets/src/application/update_budget.dart' as _i72;
import '../core/budgets/src/infrastructure/budget_repository_impl.dart' as _i17;
import '../core/budgets/src/infrastructure/datasources/local/budget_mapper.dart'
    as _i15;
import '../core/budgets/src/infrastructure/datasources/local/budgets_db.dart'
    as _i14;
import '../core/budgets/src/infrastructure/datasources/local/budgets_local_data_source.dart'
    as _i19;
import '../core/budgets/src/infrastructure/datasources/local/budgets_table.dart'
    as _i13;
import '../core/categories/application.dart' as _i38;
import '../core/categories/domain.dart' as _i25;
import '../core/categories/infrastructure.dart' as _i20;
import '../core/categories/src/application/create_category.dart' as _i29;
import '../core/categories/src/application/create_sub_category.dart' as _i81;
import '../core/categories/src/application/delete_category.dart' as _i32;
import '../core/categories/src/application/delete_sub_category.dart' as _i83;
import '../core/categories/src/application/get_categories.dart' as _i48;
import '../core/categories/src/application/get_sub_categories.dart' as _i86;
import '../core/categories/src/application/save_categories.dart' as _i58;
import '../core/categories/src/application/save_sub_categories.dart' as _i89;
import '../core/categories/src/application/update_category.dart' as _i73;
import '../core/categories/src/application/update_sub_category.dart' as _i74;
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
    as _i61;
import '../core/categories/src/infrastructure/sub_category_repository_impl.dart'
    as _i62;
import '../core/records/domain.dart' as _i55;
import '../core/records/src/application/record_cubit.dart' as _i54;
import '../core/transactions/application.dart' as _i41;
import '../core/transactions/domain.dart' as _i66;
import '../core/transactions/infrastructure.dart' as _i68;
import '../core/transactions/src/application/add_transaction.dart' as _i77;
import '../core/transactions/src/application/delete_transaction.dart' as _i84;
import '../core/transactions/src/application/get_transactions.dart' as _i87;
import '../core/transactions/src/application/update_transaction.dart' as _i75;
import '../core/transactions/src/infrastructure/datasources/local/transaction_mapper.dart'
    as _i65;
import '../core/transactions/src/infrastructure/datasources/local/transactions_db.dart'
    as _i64;
import '../core/transactions/src/infrastructure/datasources/local/transactions_local_data_source.dart'
    as _i69;
import '../core/transactions/src/infrastructure/datasources/local/transactions_table.dart'
    as _i63;
import '../core/transactions/src/infrastructure/transaction_repository_impl.dart'
    as _i67;
import '../core/user/application.dart' as _i11;
import '../core/user/domain.dart' as _i78;
import '../core/user/src/application/check_auth_status.dart' as _i80;
import '../core/user/src/application/create_user.dart' as _i82;
import '../core/user/src/application/get_profile_info.dart' as _i85;
import '../core/user/src/application/log_out.dart' as _i88;
import '../core/user/src/application/pick_user_image.dart' as _i52;
import '../core/user/src/application/sign_in.dart' as _i90;
import '../core/user/src/application/update_user_info.dart' as _i91;
import '../core/user/src/infrastructure/auth/auth_service_impl.dart' as _i79;
import '../core/user/src/infrastructure/auth/user_firebase_prov.dart' as _i76;
import '../presentation/core/auth/auth_bloc.dart' as _i10;
import '../presentation/core/settings/settings_bloc.dart' as _i59;
import '../presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart'
    as _i33;
import '../presentation/screens/auth/cubit/auth_screen_cubit.dart' as _i12;
import '../presentation/screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart'
    as _i35;
import '../presentation/screens/categories/edit_category_bloc/edit_category_screen_bloc.dart'
    as _i37;
import '../presentation/screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart'
    as _i39;
import '../presentation/screens/home/cubit/home_screen_cubit.dart' as _i50;
import '../presentation/screens/profile/cubit/profile_screen_cubit.dart'
    as _i53;
import '../presentation/screens/settings/cubit/settings_screen_cubit.dart'
    as _i60;
import '../presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart'
    as _i40;
import '../presentation/screens/transactions/transactions_bloc/transactions_screen_bloc.dart'
    as _i70;
import 'db_injectable_module.dart' as _i92;
import 'facebook_injectable_module.dart' as _i93;
import 'firebase_injectable_module.dart' as _i94;
import 'image_picker_injectable_module.dart'
    as _i95; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i27.CreateAccount>(
      () => _i27.CreateAccount(get<_i6.AccountRepository>()));
  gh.factory<_i28.CreateBudget>(
      () => _i28.CreateBudget(get<_i16.BudgetRepository>()));
  gh.factory<_i29.CreateCategory>(
      () => _i29.CreateCategory(get<_i25.CategoryRepository>()));
  gh.factory<_i30.DeleteAccount>(
      () => _i30.DeleteAccount(get<_i6.AccountRepository>()));
  gh.factory<_i31.DeleteBudget>(
      () => _i31.DeleteBudget(get<_i16.BudgetRepository>()));
  gh.factory<_i32.DeleteCategory>(
      () => _i32.DeleteCategory(get<_i25.CategoryRepository>()));
  gh.factory<_i33.EditAccountScreenBloc>(() => _i33.EditAccountScreenBloc(
      get<_i34.UpdateAccount>(),
      get<_i34.DeleteAccount>(),
      get<_i11.GetProfileInfo>(),
      get<_i34.CreateAccount>()));
  gh.factory<_i35.EditBudgetScreenBloc>(() => _i35.EditBudgetScreenBloc(
      get<_i36.UpdateBudget>(),
      get<_i36.DeleteBudget>(),
      get<_i11.GetProfileInfo>(),
      get<_i36.CreateBudget>()));
  gh.factory<_i37.EditCategoryScreenBloc>(() => _i37.EditCategoryScreenBloc(
      get<_i38.UpdateCategory>(),
      get<_i38.DeleteCategory>(),
      get<_i11.GetProfileInfo>(),
      get<_i38.GetSubCategories>(),
      get<_i38.SaveSubCategories>(),
      get<_i38.CreateSubCategory>(),
      get<_i38.CreateCategory>()));
  gh.factory<_i39.EditSubCategoryScreenBloc>(() =>
      _i39.EditSubCategoryScreenBloc(
          get<_i38.UpdateSubCategory>(), get<_i38.DeleteSubCategory>()));
  gh.factory<_i40.EditTransactionScreenBloc>(() =>
      _i40.EditTransactionScreenBloc(
          get<_i41.UpdateTransaction>(),
          get<_i41.DeleteTransaction>(),
          get<_i11.GetProfileInfo>(),
          get<_i41.AddTransaction>(),
          get<_i38.SaveCategories>(),
          get<_i38.GetSubCategories>(),
          get<_i38.SaveSubCategories>()));
  gh.lazySingleton<_i42.FacebookAuth>(
      () => facebookInjectableModule.facebookAuth);
  gh.lazySingleton<_i43.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i44.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.lazySingleton<_i45.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i46.GetAccounts>(
      () => _i46.GetAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i47.GetBudgets>(
      () => _i47.GetBudgets(get<_i16.BudgetRepository>()));
  gh.factory<_i48.GetCategories>(
      () => _i48.GetCategories(get<_i25.CategoryRepository>()));
  gh.lazySingleton<_i49.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i50.HomeScreenCubit>(
      () => _i50.HomeScreenCubit(get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i51.ImagePicker>(
      () => imagePickerInjectableModule.imagePicker);
  gh.factory<_i52.PickUserImage>(
      () => _i52.PickUserImage(get<_i51.ImagePicker>()));
  gh.factory<_i53.ProfileScreenCubit>(() => _i53.ProfileScreenCubit(
      get<_i11.CheckAuthStatus>(),
      get<_i11.GetProfileInfo>(),
      get<_i11.UpdateUserInfo>(),
      get<_i11.PickUserImage>()));
  gh.factory<_i54.RecordCubit>(
      () => _i54.RecordCubit(get<_i55.RecordRepositoryBase>()));
  gh.factory<_i56.SaveAccounts>(
      () => _i56.SaveAccounts(get<_i6.AccountRepository>()));
  gh.factory<_i57.SaveBudgets>(
      () => _i57.SaveBudgets(get<_i16.BudgetRepository>()));
  gh.factory<_i58.SaveCategories>(
      () => _i58.SaveCategories(get<_i25.CategoryRepository>()));
  gh.factory<_i59.SettingsBloc>(() => _i59.SettingsBloc(
      get<_i11.GetProfileInfo>(),
      get<_i34.GetAccounts>(),
      get<_i34.SaveAccounts>(),
      get<_i38.GetCategories>(),
      get<_i38.SaveCategories>(),
      get<_i38.SaveSubCategories>(),
      get<_i36.GetBudgets>(),
      get<_i36.SaveBudgets>()));
  gh.factory<_i60.SettingsScreenCubit>(() => _i60.SettingsScreenCubit(
      get<_i11.CheckAuthStatus>(), get<_i11.GetProfileInfo>()));
  gh.lazySingleton<_i22.SubCategoryDao>(
      () => _i22.SubCategoryDao(get<_i23.CategoriesDatabase>()));
  gh.lazySingleton<_i61.SubCategoryMapper>(() => _i61.SubCategoryMapper());
  gh.lazySingleton<_i25.SubCategoryRepository>(() =>
      _i62.SubCategoryRepositoryImpl(get<_i20.CategoriesLocalDataSource>()));
  gh.lazySingleton<_i63.TransactionDao>(
      () => _i63.TransactionDao(get<_i64.TransactionsDatabase>()));
  gh.lazySingleton<_i65.TransactionMapper>(() => _i65.TransactionMapper());
  gh.lazySingleton<_i66.TransactionRepository>(() =>
      _i67.TransactionRepositoryImpl(get<_i68.TransactionsLocalDataSource>()));
  gh.lazySingleton<_i68.TransactionsDatabase>(
      () => dbInjectableModule.transctionsDatabase);
  gh.lazySingleton<_i69.TransactionsLocalDataSource>(() =>
      _i69.TransactionsLocalDataSourceImpl(
          get<_i68.TransactionDao>(), get<_i68.TransactionMapper>()));
  gh.factory<_i70.TransactionsScreenBloc>(() => _i70.TransactionsScreenBloc(
      get<_i41.GetTransactions>(), get<_i11.GetProfileInfo>()));
  gh.factory<_i71.UpdateAccount>(() => _i71.UpdateAccount(
      get<_i6.AccountRepository>(), get<_i46.GetAccounts>()));
  gh.factory<_i72.UpdateBudget>(() =>
      _i72.UpdateBudget(get<_i16.BudgetRepository>(), get<_i36.GetBudgets>()));
  gh.factory<_i73.UpdateCategory>(() => _i73.UpdateCategory(
      get<_i25.CategoryRepository>(), get<_i38.GetCategories>()));
  gh.factory<_i74.UpdateSubCategory>(() => _i74.UpdateSubCategory(
      get<_i25.SubCategoryRepository>(), get<_i38.GetSubCategories>()));
  gh.factory<_i75.UpdateTransaction>(() => _i75.UpdateTransaction(
      get<_i66.TransactionRepository>(), get<_i41.GetTransactions>()));
  gh.lazySingleton<_i76.UserFirebaseProv>(() => _i76.UserFirebaseProv(
      get<_i45.FirebaseStorage>(), get<_i44.FirebaseFirestore>()));
  gh.factory<_i77.AddTransaction>(
      () => _i77.AddTransaction(get<_i66.TransactionRepository>()));
  gh.lazySingleton<_i78.AuthService>(() => _i79.AuthServiceImpl(
      get<_i43.FirebaseAuth>(),
      get<_i49.GoogleSignIn>(),
      get<_i42.FacebookAuth>(),
      get<_i76.UserFirebaseProv>()));
  gh.factory<_i80.CheckAuthStatus>(
      () => _i80.CheckAuthStatus(get<_i78.AuthService>()));
  gh.factory<_i81.CreateSubCategory>(
      () => _i81.CreateSubCategory(get<_i25.SubCategoryRepository>()));
  gh.factory<_i82.CreateUser>(() => _i82.CreateUser(get<_i78.AuthService>()));
  gh.factory<_i83.DeleteSubCategory>(
      () => _i83.DeleteSubCategory(get<_i25.SubCategoryRepository>()));
  gh.factory<_i84.DeleteTransaction>(
      () => _i84.DeleteTransaction(get<_i66.TransactionRepository>()));
  gh.factory<_i85.GetProfileInfo>(
      () => _i85.GetProfileInfo(get<_i78.AuthService>()));
  gh.factory<_i86.GetSubCategories>(
      () => _i86.GetSubCategories(get<_i25.SubCategoryRepository>()));
  gh.factory<_i87.GetTransactions>(
      () => _i87.GetTransactions(get<_i66.TransactionRepository>()));
  gh.factory<_i88.LogOut>(() => _i88.LogOut(get<_i78.AuthService>()));
  gh.factory<_i89.SaveSubCategories>(
      () => _i89.SaveSubCategories(get<_i25.SubCategoryRepository>()));
  gh.factory<_i90.SignIn>(() => _i90.SignIn(get<_i78.AuthService>()));
  gh.factory<_i91.UpdateUserInfo>(
      () => _i91.UpdateUserInfo(get<_i78.AuthService>()));
  return get;
}

class _$DbInjectableModule extends _i92.DbInjectableModule {}

class _$FacebookInjectableModule extends _i93.FacebookInjectableModule {}

class _$FirebaseInjectableModule extends _i94.FirebaseInjectableModule {}

class _$ImagePickerInjectableModule extends _i95.ImagePickerInjectableModule {}

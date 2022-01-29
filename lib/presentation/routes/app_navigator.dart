import 'package:budgets/core/transactions/domain.dart';
import 'package:flutter/material.dart';

import '../../core/accounts/domain.dart';
import '../../core/budgets/domain.dart';
import '../../core/categories/domain.dart';

class AppNavigator {
  AppNavigator._();

  static const ROUTE_SPLASH_PAGE = Navigator.defaultRouteName;
  static const ROUTE_INTRO_PAGE = '/intro';
  static const ROUTE_AUTH_PAGE = '/auth';
  static const ROUTE_MAIN_PAGE = '/main';

  // Settings
  static const ROUTE_PROFILE_PAGE = '/profile';

  static const ROUTE_CATEGORIES_PAGE = '/categories';
  static const ROUTE_EDIT_CATEGORY_PAGE = '/edit-category';
  static const ROUTE_EDIT_CATEGORY_NAME_PAGE = '/edit-category-name';
  static const ROUTE_SELECT_CATEGORY_TYPE_PAGE = '/select-category-type';
  static const ROUTE_EDIT_SUB_CATEGORY_PAGE = '/edit-sub-category';
  static const ROUTE_EDIT_SUB_CATEGORY_NAME_PAGE = '/edit-sub-category-name';

  static const ROUTE_ACCOUNTS_PAGE = '/accounts';
  static const ROUTE_EDIT_ACCOUNT_PAGE = '/edit-account';

  static const ROUTE_BUDGETS_PAGE = '/budgets';
  static const ROUTE_EDIT_BUDGET_PAGE = '/edit-budget';

  static const ROUTE_EDIT_TRANSACTION_PAGE = '/edit-transaction';
  static const ROUTE_SELECT_ACCOUNT_PAGE = '/select-account';
  static const ROUTE_SELECT_CATEGORY_PAGE = '/select-category';
  static const ROUTE_SELECT_BUDGET_PAGE = '/select-budget';
  static const ROUTE_EDIT_NOTE_PAGE = '/edit-note';
  static const ROUTE_MANAGE_INCOME_PAGE = '/manage-income';

  static void navigateBack(BuildContext context) => Navigator.pop(context);

  static void closeFlow(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    while (navigator.canPop()) {
      navigator.maybePop();
    }
  }

  static void navigateToIntroPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_INTRO_PAGE);
  }

  static void navigateToAuthPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, ROUTE_AUTH_PAGE);
  }

  static void navigateToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      ROUTE_MAIN_PAGE,
      (route) => false,
    );
  }

  static void navigateBackToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      ROUTE_MAIN_PAGE,
      (route) => false,
    );
  }

  static void navigateToProfilePage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_PROFILE_PAGE);
  }

  static void navigateToCategoriesPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_CATEGORIES_PAGE);
  }

  static void navigateToEditCategoryPage(BuildContext context,
      {Category? category}) {
    Navigator.pushNamed(context, ROUTE_EDIT_CATEGORY_PAGE, arguments: category);
  }

  static void navigateToEditCategoryNamePage(
    BuildContext context, {
    String? name,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_CATEGORY_NAME_PAGE,
        arguments: name);
  }

  static void navigateToSelectCategoryTypePage(
    BuildContext context,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_SELECT_CATEGORY_TYPE_PAGE,
    );
  }

  static void navigateToEditSubCategoryPage(
    BuildContext context,
    SubCategory subCategory,
    Function(Object?) function,
  ) {
    Navigator.pushNamed(context, ROUTE_EDIT_SUB_CATEGORY_PAGE,
            arguments: subCategory)
        .then(function);
  }

  static void navigateToEditSubCategoryNamePage(
    BuildContext context, {
    String? name,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_SUB_CATEGORY_NAME_PAGE,
        arguments: name);
  }

  static void navigateToAccountsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_ACCOUNTS_PAGE);
  }

  static void navigateToEditAccountPage(
    BuildContext context, {
    Account? account,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_ACCOUNT_PAGE, arguments: account);
  }

  static void navigateToBudgetsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_BUDGETS_PAGE);
  }

  static void navigateToEditBudgetPage(
    BuildContext context, {
    Budget? budget,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_BUDGET_PAGE, arguments: budget);
  }

  static void navigateToEditTransactionPage(
    BuildContext context,
    Function(Object?) function, {
    Transaction? transaction,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_TRANSACTION_PAGE,
            arguments: transaction)
        .then(function);
  }

  static void navigateToSelectAccountPage(
    BuildContext context,
    List<Account>? accounts,
  ) {
    Navigator.pushNamed(context, ROUTE_SELECT_ACCOUNT_PAGE,
        arguments: accounts);
  }

  static void navigateToSelectCategoryPage(
    BuildContext context,
    List<Category>? categories,
  ) {
    Navigator.pushNamed(context, ROUTE_SELECT_CATEGORY_PAGE,
        arguments: categories);
  }

  static void navigateToSelectBudgetPage(
    BuildContext context, {
    List<Budget>? budgets,
  }) {
    Navigator.pushNamed(context, ROUTE_SELECT_BUDGET_PAGE, arguments: budgets);
  }

  static void navigateToEditNotePage(
    BuildContext context, {
    String? content,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_NOTE_PAGE, arguments: content);
  }

  static void navigateToManageIncomePage(
    BuildContext context, {
    List<dynamic>? arguments,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_MANAGE_INCOME_PAGE,
      arguments: arguments,
    );
  }
}

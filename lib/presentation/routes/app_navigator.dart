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
  static const ROUTE_SUB_CATEGORIES_PAGE = '/sub-categories';
  static const ROUTE_EDIT_CATEGORY_PAGE = '/edit-category';
  static const ROUTE_EDIT_SUB_CATEGORY_PAGE = '/edit-sub-category';

  static const ROUTE_ACCOUNTS_PAGE = '/accounts';
  static const ROUTE_EDIT_ACCOUNT_PAGE = '/edit-account';

  static const ROUTE_BUDGETS_PAGE = '/budgets';
  static const ROUTE_EDIT_BUDGET_PAGE = '/edit-budget';

  static const ROUTE_EDIT_TRANSACTION_PAGE = '/edit-transaction';

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

  static void navigateToSubCategoriesPage(
    BuildContext context,
    Category category,
  ) {
    Navigator.pushNamed(context, ROUTE_SUB_CATEGORIES_PAGE,
        arguments: category);
  }

  static void navigateToEditCategoryPage(
      BuildContext context, Function(Object?) function,
      {Category? category}) {
    Navigator.pushNamed(context, ROUTE_EDIT_CATEGORY_PAGE, arguments: category)
        .then(function);
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

  static void navigateToAccountsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_ACCOUNTS_PAGE);
  }

  static void navigateToEditAccountPage(
    BuildContext context,
    Function(Object?) function, {
    Account? account,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_ACCOUNT_PAGE, arguments: account)
        .then(function);
  }

  static void navigateToBudgetsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_BUDGETS_PAGE);
  }

  static void navigateToEditBudgetPage(
    BuildContext context,
    Function(Object?) function, {
    Budget? budget,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_BUDGET_PAGE, arguments: budget)
        .then(function);
  }
}

import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_cubit/edit_transaction_screen_cubit.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_screen.dart';
import 'package:budgets/presentation/screens/transactions/select_account_screen.dart';
import 'package:budgets/presentation/screens/transactions/select_budget_screen.dart';
import 'package:budgets/presentation/screens/transactions/select_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/accounts/domain.dart';
import '../../core/budgets/domain.dart';
import '../../core/categories/domain.dart';
import '../../di/dependency_injection.dart';
import '../screens/accounts/accounts_screen.dart';
import '../screens/accounts/edit_account_cubit/edit_account_screen_cubit.dart';
import '../screens/accounts/edit_account_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/auth/cubit/auth_screen_cubit.dart';
import '../screens/budgets/budgets_screen.dart';
import '../screens/budgets/edit_budget_cubit/edit_budget_screen_cubit.dart';
import '../screens/budgets/edit_budget_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/categories/edit_category_cubit/edit_category_screen_cubit.dart';
import '../screens/categories/edit_category_screen.dart';
import '../screens/categories/edit_sub_category_cubit/edit_sub_category_screen_cubit.dart';
import '../screens/categories/edit_sub_category_screen.dart';
import '../screens/categories/sub_categories_cubit/sub_categories_screen_cubit.dart';
import '../screens/categories/sub_categories_screen.dart';
import '../screens/intro/intro_screen.dart';
import '../screens/main/main_app_screen.dart';
import '../screens/profile/cubit/profile_screen_cubit.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'app_navigator.dart';

class Routes {
  final EditTransactionScreenCubit _editTransactionScreenCubit =
      sl<EditTransactionScreenCubit>();

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case AppNavigator.ROUTE_SPLASH_PAGE:
        return _buildRoute(
          settings,
          SplashScreen(),
        );
      case AppNavigator.ROUTE_INTRO_PAGE:
        return _buildRoute(
          settings,
          IntroScreen(),
        );
      case AppNavigator.ROUTE_AUTH_PAGE:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<AuthScreenCubit>(),
            child: AuthScreen(),
          ),
        );
      case AppNavigator.ROUTE_MAIN_PAGE:
        return _buildRoute(
          settings,
          MainAppScreen(),
        );
      case AppNavigator.ROUTE_PROFILE_PAGE:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<ProfileScreenCubit>(),
            child: ProfileSreen(),
          ),
        );
      case AppNavigator.ROUTE_CATEGORIES_PAGE:
        return _buildRoute(
          settings,
          CategoriesScreen(),
        );
      case AppNavigator.ROUTE_SUB_CATEGORIES_PAGE:
        final category = settings.arguments! as Category;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<SubCategoriesScreenCubit>(),
            child: SubCategoriesScreen(category: category),
          ),
        );
      case AppNavigator.ROUTE_EDIT_CATEGORY_PAGE:
        final category = settings.arguments;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<EditCategoryScreenCubit>(),
            child: EditCategoryScreen(category: category as Category?),
          ),
        );
      case AppNavigator.ROUTE_EDIT_SUB_CATEGORY_PAGE:
        final subCategory = settings.arguments! as SubCategory;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<EditSubCategoryScreenCubit>(),
            child: EditSubCategoryScreen(subCategory: subCategory),
          ),
        );
      case AppNavigator.ROUTE_ACCOUNTS_PAGE:
        return _buildRoute(
          settings,
          AccountsScreen(),
        );
      case AppNavigator.ROUTE_EDIT_ACCOUNT_PAGE:
        final account = settings.arguments;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<EditAccountScreenCubit>(),
            child: EditAccountScreen(account: account as Account?),
          ),
        );
      case AppNavigator.ROUTE_BUDGETS_PAGE:
        return _buildRoute(
          settings,
          BudgetsScreen(),
        );
      case AppNavigator.ROUTE_EDIT_BUDGET_PAGE:
        final budget = settings.arguments;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<EditBudgetScreenCubit>(),
            child: EditBudgetScreen(budget: budget as Budget?),
          ),
        );
      case AppNavigator.ROUTE_EDIT_TRANSACTION_PAGE:
        final transaction = settings.arguments;
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: _editTransactionScreenCubit,
            child:
                EditTransactionScreen(transaction: transaction as Transaction?),
          ),
        );
      case AppNavigator.ROUTE_SELECT_CATEGORY_PAGE:
        final categories = settings.arguments;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: SelectCategoryScreen(
              categories: categories as List<Category>?,
            ),
          ),
        );
      case AppNavigator.ROUTE_SELECT_ACCOUNT_PAGE:
        final accounts = settings.arguments!;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: SelectAccountScreen(
              accounts: accounts as List<Account>,
            ),
          ),
        );
      case AppNavigator.ROUTE_SELECT_BUDGET_PAGE:
        final budgets = settings.arguments!;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: SelectBudgetScreen(
              budgets: budgets as List<Budget>,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget screen,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  }
}

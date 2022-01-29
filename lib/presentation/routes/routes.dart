import 'package:budgets/core/transactions/domain.dart';
import 'package:budgets/presentation/screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart';
import 'package:budgets/presentation/screens/categories/edit_category_name_screen.dart';
import 'package:budgets/presentation/screens/categories/edit_sub_category_name_screen.dart';
import 'package:budgets/presentation/screens/categories/select_category_type_screen.dart';
import 'package:budgets/presentation/screens/transactions/edit_note_screen.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_cubit/edit_transaction_screen_cubit.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_screen.dart';
import 'package:budgets/presentation/screens/transactions/manage_income_screen.dart';
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
import '../screens/intro/intro_screen.dart';
import '../screens/main/main_app_screen.dart';
import '../screens/profile/cubit/profile_screen_cubit.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'app_navigator.dart';

class AppRouter {
  final EditTransactionScreenCubit _editTransactionScreenCubit =
      sl<EditTransactionScreenCubit>();

  final EditCategoryScreenCubit _editCategoryScreenCubit =
      sl<EditCategoryScreenCubit>();

  final EditSubCategoryScreenCubit _editSubCategoryScreenCubit =
      sl<EditSubCategoryScreenCubit>();

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
      case AppNavigator.ROUTE_EDIT_CATEGORY_PAGE:
        final category = settings.arguments as Category?;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editCategoryScreenCubit,
            child: EditCategoryScreen(category: category),
          ),
        );
      case AppNavigator.ROUTE_EDIT_CATEGORY_NAME_PAGE:
        final name = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editCategoryScreenCubit,
            child: EditCategoryNameScreen(
              name: name,
            ),
          ),
        );
      case AppNavigator.ROUTE_SELECT_CATEGORY_TYPE_PAGE:
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editCategoryScreenCubit,
            child: SelectCategoryTypeScreen(),
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
      case AppNavigator.ROUTE_EDIT_SUB_CATEGORY_NAME_PAGE:
        final name = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editSubCategoryScreenCubit,
            child: EditSubCategoryNameScreen(
              name: name,
            ),
          ),
        );
      case AppNavigator.ROUTE_ACCOUNTS_PAGE:
        return _buildRoute(
          settings,
          AccountsScreen(),
        );
      case AppNavigator.ROUTE_EDIT_ACCOUNT_PAGE:
        final account = settings.arguments as Account?;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<EditAccountScreenBloc>(),
            child: EditAccountScreen(account: account),
          ),
        );
      case AppNavigator.ROUTE_BUDGETS_PAGE:
        return _buildRoute(
          settings,
          BudgetsScreen(),
        );
      case AppNavigator.ROUTE_EDIT_BUDGET_PAGE:
        final budget = settings.arguments as Budget?;
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) => sl<EditBudgetScreenCubit>(),
            child: EditBudgetScreen(budget: budget),
          ),
        );
      case AppNavigator.ROUTE_EDIT_TRANSACTION_PAGE:
        final transaction = settings.arguments as Transaction?;
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: EditTransactionScreen(transaction: transaction),
          ),
        );
      case AppNavigator.ROUTE_SELECT_ACCOUNT_PAGE:
        final accounts = settings.arguments! as List<Account>;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: SelectAccountScreen(
              accounts: accounts,
            ),
          ),
        );
      case AppNavigator.ROUTE_SELECT_CATEGORY_PAGE:
        final categories = settings.arguments as List<Category>?;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: SelectCategoryScreen(
              categories: categories,
            ),
          ),
        );

      case AppNavigator.ROUTE_SELECT_BUDGET_PAGE:
        final budgets = settings.arguments! as List<Budget>;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: SelectBudgetScreen(
              budgets: budgets,
            ),
          ),
        );
      case AppNavigator.ROUTE_EDIT_NOTE_PAGE:
        final content = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: EditNoteScreen(
              content: content,
            ),
          ),
        );
      case AppNavigator.ROUTE_MANAGE_INCOME_PAGE:
        final arguments = settings.arguments! as List<dynamic>;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenCubit,
            child: ManageIncomeScreen(
              budgets: arguments[0] as List<Budget>,
              incomeAmount: arguments[1] as String,
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

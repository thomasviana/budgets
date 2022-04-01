import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/accounts/domain.dart';
import '../../core/budgets/domain.dart';
import '../../core/categories/domain.dart';
import '../../core/transactions/domain.dart';
import '../../di/dependency_injection.dart';
import '../core/stats/stats_bloc.dart';
import '../core/transactions/transactions_bloc.dart';
import '../screens/accounts/accounts_screen.dart';
import '../screens/accounts/edit_account_bloc/edit_account_screen_bloc.dart';
import '../screens/accounts/edit_account_name_screen.dart';
import '../screens/accounts/edit_account_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/auth/cubit/auth_screen_cubit.dart';
import '../screens/budgets/budgets_screen.dart';
import '../screens/budgets/edit_budget_abbreviation_screen.dart';
import '../screens/budgets/edit_budget_bloc/edit_budget_screen_bloc.dart';
import '../screens/budgets/edit_budget_name_screen.dart';
import '../screens/budgets/edit_budget_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/categories/edit_category_bloc/edit_category_screen_bloc.dart';
import '../screens/categories/edit_category_name_screen.dart';
import '../screens/categories/edit_category_screen.dart';
import '../screens/categories/edit_sub_category_bloc/edit_sub_category_screen_bloc.dart';
import '../screens/categories/edit_sub_category_name_screen.dart';
import '../screens/categories/edit_sub_category_screen.dart';
import '../screens/categories/select_category_type_screen.dart';
import '../screens/intro/intro_screen.dart';
import '../screens/main/main_app_cubit/main_screen_cubit.dart';
import '../screens/main/main_app_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/profile_screen_bloc/profile_sceen_bloc.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/stats_budgets/budgets_stats_sreen.dart';
import '../screens/stats_cash_flow.dart/cash_flow_screen.dart.dart';
import '../screens/stats_expenses/expenses_screen.dart';
import '../screens/stats_incomes/incomes_screen.dart';
import '../screens/transactions/edit_note_screen.dart';
import '../screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart';
import '../screens/transactions/edit_transaction_screen.dart';
import '../screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart';
import '../screens/transactions/manage_income_screen.dart';
import '../screens/transactions/select_account_screen.dart';
import '../screens/transactions/select_budget_screen.dart';
import '../screens/transactions/select_category_screen.dart';
import 'app_navigator.dart';

class AppRouter {
  final EditTransactionScreenBloc _editTransactionScreenBloc =
      sl<EditTransactionScreenBloc>();

  final EditCategoryScreenBloc _editCategoryScreenBloc =
      sl<EditCategoryScreenBloc>();

  final EditSubCategoryScreenBloc _editSubCategoryScreenBloc =
      sl<EditSubCategoryScreenBloc>();

  final EditAccountScreenBloc _editAccountScreenBloc =
      sl<EditAccountScreenBloc>();

  final EditBudgetScreenBloc _editBudgetScreenBloc = sl<EditBudgetScreenBloc>();

  final TransactionsBloc _transactionsBloc = sl<TransactionsBloc>()
    ..add(TransactionsRequested());

  final StatsBloc _statsBloc = sl<StatsBloc>()
    ..add(CategoriesSuscriptionRequested())
    ..add(BudgetsSuscriptionRequested())
    ..add(AccountsSuscriptionRequested())
    ..add(TransactionsSuscriptionRequested());

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
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<MainScreenCubit>(),
              ),
              BlocProvider.value(
                value: _transactionsBloc,
              ),
              BlocProvider.value(
                value: _statsBloc,
              ),
            ],
            child: MainAppScreen(),
          ),
        );
      case AppNavigator.ROUTE_INCOMES_PAGE:
        return _buildRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _statsBloc,
              ),
              BlocProvider.value(
                value: _transactionsBloc,
              ),
            ],
            child: IncomesScreen(),
          ),
        );
      case AppNavigator.ROUTE_EXPENSES_PAGE:
        return _buildRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _statsBloc,
              ),
              BlocProvider.value(
                value: _transactionsBloc,
              ),
            ],
            child: ExpensesScreen(),
          ),
        );
      case AppNavigator.ROUTE_CASH_FLOW_PAGE:
        return _buildRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _statsBloc,
              ),
              BlocProvider.value(
                value: _transactionsBloc,
              ),
            ],
            child: CashFlowScreen(),
          ),
        );
      case AppNavigator.ROUTE_BUDGETS_STATS_PAGE:
        return _buildRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _statsBloc,
              ),
              BlocProvider.value(
                value: _transactionsBloc,
              ),
            ],
            child: BudgetsStatsScreen(),
          ),
        );
      case AppNavigator.ROUTE_PROFILE_PAGE:
        return _buildRoute(
          settings,
          BlocProvider(
            create: (context) =>
                sl<ProfileScreenBloc>()..add(ProfileInfoSuscriptionRequested()),
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
            value: _editCategoryScreenBloc,
            child: EditCategoryScreen(category: category),
          ),
        );
      case AppNavigator.ROUTE_EDIT_CATEGORY_NAME_PAGE:
        final name = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editCategoryScreenBloc,
            child: EditCategoryNameScreen(
              name: name,
            ),
          ),
        );
      case AppNavigator.ROUTE_SELECT_CATEGORY_TYPE_PAGE:
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editCategoryScreenBloc,
            child: SelectCategoryTypeScreen(),
          ),
        );
      case AppNavigator.ROUTE_EDIT_SUB_CATEGORY_PAGE:
        final subCategory = settings.arguments! as SubCategory;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editSubCategoryScreenBloc,
            child: EditSubCategoryScreen(subCategory: subCategory),
          ),
        );
      case AppNavigator.ROUTE_EDIT_SUB_CATEGORY_NAME_PAGE:
        final name = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editSubCategoryScreenBloc,
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
          BlocProvider.value(
            value: _editAccountScreenBloc,
            child: EditAccountScreen(account: account),
          ),
        );
      case AppNavigator.ROUTE_EDIT_ACCOUNT_NAME_PAGE:
        final name = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editAccountScreenBloc,
            child: EditAccountNameScreen(
              name: name,
            ),
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
          BlocProvider.value(
            value: _editBudgetScreenBloc,
            child: EditBudgetScreen(budget: budget),
          ),
        );
      case AppNavigator.ROUTE_EDIT_BUDGET_NAME_PAGE:
        final name = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editBudgetScreenBloc,
            child: EditBudgetNameScreen(
              name: name,
            ),
          ),
        );
      case AppNavigator.ROUTE_EDIT_BUDGET_ABBREVIATION_PAGE:
        final abbreviation = settings.arguments! as String;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editBudgetScreenBloc,
            child: EditBudgetAbbreviationScreen(
              abbreviation: abbreviation,
            ),
          ),
        );
      case AppNavigator.ROUTE_EDIT_TRANSACTION_PAGE:
        final transaction = settings.arguments as Transaction?;
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: _editTransactionScreenBloc,
            child: EditTransactionScreen(transaction: transaction),
          ),
        );
      case AppNavigator.ROUTE_SELECT_ACCOUNT_PAGE:
        final accounts = settings.arguments! as List<Account>;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenBloc,
            child: SelectAccountScreen(
              accounts: accounts,
            ),
          ),
        );
      case AppNavigator.ROUTE_SELECT_CATEGORY_PAGE:
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenBloc,
            child: SelectCategoryScreen(),
          ),
        );

      case AppNavigator.ROUTE_SELECT_BUDGET_PAGE:
        final budgets = settings.arguments! as List<Budget>;
        return _buildRoute(
          settings,
          BlocProvider.value(
            value: _editTransactionScreenBloc,
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
            value: _editTransactionScreenBloc,
            child: EditNoteScreen(
              content: content,
            ),
          ),
        );
      case AppNavigator.ROUTE_MANAGE_INCOME_PAGE:
        final arguments = settings.arguments! as List<dynamic>;
        return _buildRoute(
          settings,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<ManageIncomeScreenBloc>(),
              ),
              BlocProvider.value(
                value: _editTransactionScreenBloc,
              ),
            ],
            child: ManageIncomeScreen(
              transactionId: arguments[0] as TransactionId,
              budgets: arguments[1] as List<Budget>,
              incomeAmount: arguments[2] as double,
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

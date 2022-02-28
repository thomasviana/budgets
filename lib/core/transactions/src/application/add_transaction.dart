import 'package:budgets/core/user/application.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class AddTransaction {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;

  const AddTransaction(
    this._transactionRepository,
    this._getProfileInfo,
  );

  Future<void>? call({
    required TransactionType txType,
    required String title,
    required double amount,
    required DateTime date,
    required String note,
    required int icon,
    required int color,
    TransactionUserId? txUserId,
    TransactionCategoryId? txCategoryId,
    TransactionSubCategoryId? txSubCategoryId,
    TransactionAccountId? txAccountId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    bool isIncomeManaged = false,
    Map<String, dynamic>? budgetManagement,
  }) async {
    _getProfileInfo().then(
      (optionUser) => optionUser.fold(
        () {},
        (user) {
          _transactionRepository.save(
            Transaction(
              id: TransactionId.auto(),
              transactionType: txType,
              title: title,
              amount: amount,
              date: date,
              note: note,
              icon: icon,
              color: color,
              txUserId: TransactionUserId(user.id.value),
              txAccountId: txAccountId,
              txCategoryId: txCategoryId,
              txSubCategoryId: txSubCategoryId,
              txBudgetId: txBudgetId,
              incomeType: incomeType,
              isIncomeManaged: isIncomeManaged,
              budgetManagement: budgetManagement,
            ),
          );
        },
      ),
    );
  }
}

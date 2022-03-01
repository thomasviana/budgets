// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetManagement _$BudgetManagementFromJson(Map<String, dynamic> json) =>
    BudgetManagement(
      budgetToAmount: (json['budgetToAmount'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            )),
      ),
    );

Map<String, dynamic> _$BudgetManagementToJson(BudgetManagement instance) =>
    <String, dynamic>{
      'budgetToAmount': instance.budgetToAmount,
    };

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TransactionDaoMixin on DatabaseAccessor<TransactionsDatabase> {
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
}

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/extensions.dart';
import '../../../core/budgets/domain.dart';
import '../../resources/resources.dart';
import 'manage_income_bloc/manage_income_screen_bloc.dart';

class ManageIncomeBudgetScreen extends StatefulWidget {
  final Budget budget;
  final int index;
  const ManageIncomeBudgetScreen({
    Key? key,
    required this.budget,
    required this.index,
  }) : super(key: key);
  @override
  State<ManageIncomeBudgetScreen> createState() =>
      _ManageIncomeBudgetScreenState();
}

class _ManageIncomeBudgetScreenState extends State<ManageIncomeBudgetScreen> {
  late ManageIncomeScreenBloc bloc;
  late TextEditingController textEditingController;
  late CurrencyTextInputFormatter currencyTextInputFormatter;

  @override
  void initState() {
    bloc = context.read<ManageIncomeScreenBloc>();

    textEditingController = TextEditingController()
      ..text = bloc.state.budgetAmounts![widget.index].toCurrencyFormat();
    currencyTextInputFormatter =
        CurrencyTextInputFormatter(symbol: '\$', decimalDigits: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageIncomeScreenBloc, ManageIncomeScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, ManageIncomeScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      bool hasAbbreviation = true;
      if (widget.budget.abbreviation == null ||
          widget.budget.abbreviation!.isEmpty) {
        hasAbbreviation = false;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalle'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    offset: Offset(0, 2.0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(widget.budget.color),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      hasAbbreviation
                          ? widget.budget.abbreviation!
                          : widget.budget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.budgetAmounts![widget.index].toCurrencyFormat(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Material(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.greyDisabled.withOpacity(0.2),
                            child: TextButton(
                              child: Text(
                                '-1',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: state.isDecrementEnabled(
                                    widget.index,
                                    0.01,
                                  )
                                      ? AppColors.primaryColor
                                      : AppColors.greyDisabled,
                                ),
                              ),
                              onPressed:
                                  state.isDecrementEnabled(widget.index, 0.01)
                                      ? () => bloc.add(
                                            BudgetDecremented(
                                              index: widget.index,
                                              step: 1,
                                            ),
                                          )
                                      : null,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Material(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.greyDisabled.withOpacity(0.2),
                            child: TextButton(
                              child: Text(
                                '-10',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: state.isDecrementEnabled(
                                    widget.index,
                                    0.1,
                                  )
                                      ? AppColors.primaryColor
                                      : AppColors.greyDisabled,
                                ),
                              ),
                              onPressed:
                                  state.isDecrementEnabled(widget.index, 0.1)
                                      ? () => bloc.add(
                                            BudgetDecremented(
                                              index: widget.index,
                                              step: 10,
                                            ),
                                          )
                                      : null,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          state.budgetPercentages![widget.index]
                              .toPercentFormat(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Column(
                        children: [
                          Material(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.greyDisabled.withOpacity(0.2),
                            child: TextButton(
                              child: Text(
                                '+1',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: state.isIncrementEnabled(
                                    widget.index,
                                    0.01,
                                  )
                                      ? AppColors.primaryColor
                                      : AppColors.greyDisabled,
                                ),
                              ),
                              onPressed:
                                  state.isIncrementEnabled(widget.index, 0.01)
                                      ? () => bloc.add(
                                            BudgetIncremented(
                                              index: widget.index,
                                              step: 1,
                                            ),
                                          )
                                      : null,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Material(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.greyDisabled.withOpacity(0.2),
                            child: TextButton(
                              child: Text(
                                '+10',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: state.isIncrementEnabled(
                                    widget.index,
                                    0.1,
                                  )
                                      ? AppColors.primaryColor
                                      : AppColors.greyDisabled,
                                ),
                              ),
                              onPressed:
                                  state.isIncrementEnabled(widget.index, 0.1)
                                      ? () => bloc.add(
                                            BudgetIncremented(
                                              index: widget.index,
                                              step: 10,
                                            ),
                                          )
                                      : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

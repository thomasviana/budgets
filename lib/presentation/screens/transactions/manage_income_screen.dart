import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_bloc/edit_transaction_screen_bloc.dart';
import 'package:budgets/presentation/screens/transactions/manage_income_bloc/manage_income_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageIncomeScreen extends StatefulWidget {
  final List<Budget> budgets;
  final double incomeAmount;
  const ManageIncomeScreen({
    Key? key,
    required this.budgets,
    required this.incomeAmount,
  }) : super(key: key);
  @override
  State<ManageIncomeScreen> createState() => _ManageIncomeScreenState();
}

class _ManageIncomeScreenState extends State<ManageIncomeScreen> {
  late ManageIncomeScreenBloc bloc;

  @override
  void initState() {
    bloc = context.read<ManageIncomeScreenBloc>()
      ..add(
        CheckInitialValues(
          budgets: widget.budgets,
          incomeAmount: widget.incomeAmount,
        ),
      );
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
      return Scaffold(
        appBar: AppBar(
          title: Text('Administrar'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => AppNavigator.navigateBack(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                child: Text(
                  'Hecho',
                  style: TextStyle(
                    color: state.isDoneEnabled
                        ? AppColors.primaryColor
                        : AppColors.greyDisabled,
                  ),
                ),
                onPressed: state.isDoneEnabled
                    ? () {
                        bloc.add(IncomeManaged());
                        context.read<EditTransactionScreenBloc>().add(
                              IncomeManagementDone(),
                            );
                        AppNavigator.navigateBack(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding),
              // ? Option 1
              Text('Ingreso'),
              const SizedBox(height: 8),
              Text(
                '\$${currency.format(widget.incomeAmount)}',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Administrado'),
                        const SizedBox(height: 8),
                        Text(
                          '\$${currency.format(state.managedAmount)}',
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Pendiente'),
                        const SizedBox(height: 8),
                        Text(
                          '\$${currency.format(state.pendingAmount)}',
                          style: TextStyle(
                            color: AppColors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ? Option 2
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Ingreso'),
              //       Text(
              //         '\$${currency.format(widget.incomeAmount)}',
              //         style: TextStyle(
              //           color: AppColors.primaryColor,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Administrado'),
              //       Text(
              //         '\$${currency.format(state.managedAmount)}',
              //         style: TextStyle(
              //           color: AppColors.green,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Pendiente'),
              //       Text(
              //         '\$${currency.format(state.pendingAmount)}',
              //         style: TextStyle(
              //           color: AppColors.amber,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: kDefaultPadding),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
                child: Text(
                  'Asigna un porcentaje de tu ingreso a cada uno de tus presupuestos',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 9 / 7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.budgets!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final budget = state.budgets![index];
                    return Container(
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
                              color: Color(budget.color),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              budget.abbreviation ?? budget.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Text(
                            '\$${currency.format(state.budgetAmounts![index])}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                type: MaterialType.transparency,
                                clipBehavior: Clip.hardEdge,
                                shape: CircleBorder(),
                                child: IconButton(
                                  onPressed: state.isDecrementEnabled(index)
                                      ? () => bloc.add(
                                            BudgetDecremented(index: index),
                                          )
                                      : null,
                                  icon: Icon(
                                    Icons.remove,
                                    color: state.isDecrementEnabled(index)
                                        ? AppColors.primaryColor
                                        : AppColors.greyDisabled,
                                  ),
                                ),
                              ),
                              Text(
                                percentage
                                    .format(state.budgetPercentages![index]),
                              ),
                              Material(
                                type: MaterialType.transparency,
                                clipBehavior: Clip.hardEdge,
                                shape: CircleBorder(),
                                child: IconButton(
                                  onPressed: state.isIncrementEnabled(index)
                                      ? () => bloc.add(
                                            BudgetIncremented(index: index),
                                          )
                                      : null,
                                  icon: Icon(
                                    Icons.add,
                                    color: state.isIncrementEnabled(index)
                                        ? AppColors.primaryColor
                                        : AppColors.greyDisabled,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

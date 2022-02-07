import 'package:budgets/core/budgets/domain.dart';
import 'package:budgets/presentation/resources/resources.dart';
import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

class ManageIncomeScreen extends StatelessWidget {
  final List<Budget> budgets;
  final double incomeAmount;
  const ManageIncomeScreen({
    Key? key,
    required this.budgets,
    required this.incomeAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrar'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => AppNavigator.navigateBack(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text(
                '\$${currency.format(incomeAmount)}',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
                  child: Text(
                    'Asigna un porcentaje de tu ingreso a cada uno de tus presupuestos',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 9 / 7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: budgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      final budget = budgets[index];
                      bool hasAbbreviation = true;
                      if (budget.abbreviation == null ||
                          budget.abbreviation!.isEmpty) {
                        hasAbbreviation = false;
                      }
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
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
                              child: hasAbbreviation
                                  ? Text(
                                      budget.abbreviation!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    )
                                  : Icon(
                                      Icons.inbox,
                                      color: AppColors.white,
                                    ),
                            ),
                            Text('\$100'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text('10%'),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
                      );
                      // return ListTile(
                      //   leading: CircleAvatar(
                      //     maxRadius: 20,
                      //     backgroundColor: Color(budget.color),
                      //     child: hasAbbreviation
                      //         ? Text(
                      //             budget.abbreviation!,
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.bold,
                      //               color: AppColors.white,
                      //             ),
                      //           )
                      //         : Icon(
                      //             Icons.inbox,
                      //             color: AppColors.white,
                      //           ),
                      //   ),
                      //   title: Text(
                      //     budget.name,
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      //   trailing: state.budget.fold(
                      //     () => null,
                      //     (stateBudget) {
                      //       if (stateBudget.id == budget.id) {
                      //         return Icon(Icons.check,
                      //             color: AppColors.primaryColor);
                      //       }
                      //     },
                      //   ),
                      //   onTap: () {
                      //     context
                      //         .read<EditTransactionScreenBloc>()
                      //         .add(BudgetSelected(budget: budget));
                      //     Navigator.pop(context);
                      //   },
                      // );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

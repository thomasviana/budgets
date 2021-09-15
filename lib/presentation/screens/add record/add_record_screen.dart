import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budgets/data/models/record.dart';
import 'package:budgets/data/repository/implementation/user_repository.dart';
import 'package:budgets/presentation/widgets/custom_textfield.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/bloc/cubit/record_cubit.dart';
import 'package:budgets/src/bloc/cubit/user_cubit.dart';

import 'components/buttons_add_record.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  TextEditingController newAmount = TextEditingController();
  TextEditingController newConcept = TextEditingController();
  TextEditingController newBudget = TextEditingController();
  Timestamp dateTime = Timestamp.now();

  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Expense'),
    1: Text('Income'),
  };

  final Map<int, Widget> incomeType = const <int, Widget>{
    0: Text('Active Income'),
    1: Text('Pasive Income'),
  };

  int? incomeTypeVal = 1;
  int? currentValue = 0;
  String budgetTag = 'AI';

  Future<void> _submitData() async {
    final newRecord = Record(
        id: 'sss',
        title: newConcept.text,
        tag: newBudget.text,
        amount: double.parse(newAmount.text),
        date: Timestamp.now(),
        type: 'type');
    Navigator.pop(context);

    final userId = (context.read<AuthCubit>().state as AuthSignedIn).user.uid;

    await context.read<RecordCubit>().addRecord(userId, newRecord);
    print(newRecord.title);
  }

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    Widget buildDatePicker() => SizedBox(
          height: 150,
          child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: DateTime(DateTime.now().year, 2, 1),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (dateTime) {
                Timestamp timeStamp = Timestamp.fromDate(dateTime);
                setState(() {
                  this.dateTime = timeStamp;
                });
              }),
        );

    return BlocProvider(
      create: (context) => UserCubit(UserRepository())..getUser(),
      child: makeDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.95,
          maxChildSize: 0.95,
          builder: (context, controller) => Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: ListView(
              controller: controller,
              children: [
                CupertinoSlidingSegmentedControl(
                  children: children,
                  onValueChanged: (int? value) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                  groupValue: currentValue,
                ),
                SizedBox(height: 30),
                CustomTextField(
                  controller: newAmount,
                  prefixIcon:
                      Icon(Icons.attach_money_rounded, color: Colors.black),
                  hintText: 'Enter Amount',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmit: _submitData,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: newConcept,
                  prefixIcon: Icon(Icons.notes_rounded, color: Colors.black),
                  hintText: 'Enter Concept',
                  keyboardType: TextInputType.name,
                  onSubmit: _submitData,
                ),
                SizedBox(
                  height: 30,
                ),
                if (currentValue == 0)
                  CustomTextField(
                    controller: newBudget,
                    prefixIcon:
                        Icon(Icons.all_inbox_rounded, color: Colors.black),
                    hintText: 'Enter Budget',
                    keyboardType: TextInputType.name,
                    onSubmit: _submitData,
                  ),
                if (currentValue == 1)
                  CupertinoSlidingSegmentedControl(
                    children: incomeType,
                    onValueChanged: (int? value) {
                      setState(() {
                        incomeTypeVal = value;
                      });
                    },
                    groupValue: incomeTypeVal,
                  ),
                if (currentValue == 1) SizedBox(height: 30),
                if (currentValue == 0) SizedBox(height: 30),
                buildDatePicker(),
                SizedBox(height: 30),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      ButtonAddRecord(
                        color: Colors.black12,
                        title: 'Cancel',
                        onPress: () {
                          newAmount.clear();
                          newConcept.clear();
                          newBudget.clear();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 15),
                      ButtonAddRecord(
                        color: Theme.of(context).accentColor,
                        title: 'Add',
                        onPress: () {
                          _submitData();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

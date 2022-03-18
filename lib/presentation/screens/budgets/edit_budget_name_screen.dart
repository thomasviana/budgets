import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_budget_bloc/edit_budget_screen_bloc.dart';

class EditBudgetNameScreen extends StatefulWidget {
  final String name;
  const EditBudgetNameScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<EditBudgetNameScreen> createState() => _EditBudgetNameScreenState();
}

class _EditBudgetNameScreenState extends State<EditBudgetNameScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController()..text = widget.name;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        navigationBar: CupertinoNavigationBar(
          middle: Text('Nombre'),
          previousPageTitle: AppLocalizations.of(context)!.misc_back,
          trailing: GestureDetector(
            child: Icon(
              CupertinoIcons.checkmark_circle,
              color: AppColors.primaryColor,
            ),
            onTap: () {
              context
                  .read<EditBudgetScreenBloc>()
                  .add(NameChanged(textEditingController.text.trim()));
              AppNavigator.navigateBack(context);
            },
          ),
        ),
        child: Material(
          child: EditCategoryNameContent(
            textEditingController: textEditingController,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text('Nombre'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: AppColors.white,
              ),
              onPressed: () {
                context
                    .read<EditBudgetScreenBloc>()
                    .add(NameChanged(textEditingController.text.trim()));
                AppNavigator.navigateBack(context);
              },
            ),
          ],
        ),
        body: EditCategoryNameContent(
          textEditingController: textEditingController,
        ),
      );
    }
  }
}

class EditCategoryNameContent extends StatelessWidget {
  const EditCategoryNameContent({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 50,
        ),
        TextField(
          controller: textEditingController,
          keyboardType: TextInputType.name,
          autofocus: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            label: Center(
              child: Text(
                'Nuevo nombre',
              ),
            ),
            labelStyle: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            hintStyle: TextStyle(fontSize: 18),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: '',
          ),
        )
      ],
    );
  }
}

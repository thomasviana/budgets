import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_budget_bloc/edit_budget_screen_bloc.dart';

class EditBudgetAbbreviationScreen extends StatefulWidget {
  final String abbreviation;
  const EditBudgetAbbreviationScreen({
    Key? key,
    required this.abbreviation,
  }) : super(key: key);

  @override
  State<EditBudgetAbbreviationScreen> createState() =>
      _EditBudgetAbbreviationScreenState();
}

class _EditBudgetAbbreviationScreenState
    extends State<EditBudgetAbbreviationScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController()..text = widget.abbreviation;
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
          middle: Text('Abreviatura'),
          previousPageTitle: AppLocalizations.of(context)!.misc_back,
          trailing: GestureDetector(
            child: Icon(
              CupertinoIcons.checkmark_circle,
              color: AppColors.primaryColor,
            ),
            onTap: () {
              context
                  .read<EditBudgetScreenBloc>()
                  .add(AbbreviationChanged(textEditingController.text.trim()));
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
          title: Text('Abreviatura'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: AppColors.white,
              ),
              onPressed: () {
                context.read<EditBudgetScreenBloc>().add(
                      AbbreviationChanged(textEditingController.text.trim()),
                    );
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
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: TextField(
            controller: textEditingController,
            keyboardType: TextInputType.name,
            autofocus: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLength: 3,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              label: Center(
                child: Text(
                  'Nueva abreviatura',
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
          ),
        )
      ],
    );
  }
}

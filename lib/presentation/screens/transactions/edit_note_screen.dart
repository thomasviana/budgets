import 'package:budgets/presentation/routes/app_navigator.dart';
import 'package:budgets/presentation/screens/transactions/edit_transaction_cubit/edit_transaction_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';

class EditNoteScreen extends StatefulWidget {
  final String content;
  const EditNoteScreen({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController()..text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => AppNavigator.navigateBack(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('Listo'),
              onPressed: () {
                context
                    .read<EditTransactionScreenCubit>()
                    .onNoteUpdated(textEditingController.text.trim());
                AppNavigator.navigateBack(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
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
                  'Agregar nota',
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
      ),
    );
  }
}

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

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
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(
                'Listo',
                style: TextStyle(
                  color:
                      Platform.isIOS ? AppColors.primaryColor : AppColors.white,
                ),
              ),
              onPressed: () {
                context
                    .read<EditTransactionScreenBloc>()
                    .add(NoteUpdated(note: textEditingController.text.trim()));
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
              hintText: '',
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_sub_category_bloc/edit_sub_category_screen_bloc.dart';

class EditSubCategoryNameScreen extends StatefulWidget {
  final String name;
  const EditSubCategoryNameScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<EditSubCategoryNameScreen> createState() =>
      _EditSubCategoryNameScreenState();
}

class _EditSubCategoryNameScreenState extends State<EditSubCategoryNameScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController()..text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSubCategoryScreenBloc, EditSubCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditSubCategoryScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre'),
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
                    .read<EditSubCategoryScreenBloc>()
                    .add(NameChanged(textEditingController.text.trim()));
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
      ),
    );
  }
}

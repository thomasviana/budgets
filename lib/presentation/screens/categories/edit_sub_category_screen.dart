import 'package:budgets/presentation/resources/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_sub_category_cubit/edit_sub_category_screen_cubit.dart';

class EditSubCategoryScreen extends StatefulWidget {
  final SubCategory subCategory;
  const EditSubCategoryScreen({
    Key? key,
    required this.subCategory,
  }) : super(key: key);
  @override
  _EditSubCategoryScreenState createState() => _EditSubCategoryScreenState();
}

class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  late EditSubCategoryScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditSubCategoryScreenCubit>();
    cubit.init(widget.subCategory);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSubCategoryScreenCubit, EditSubCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditSubCategoryScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Edit subcategory'),
              previousPageTitle: 'Back',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      cubit.onSubCategoryDeleted();
                      AppNavigator.navigateBack(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      cubit.onSubCategorySaved();
                      AppNavigator.navigateBack(context);
                    },
                  ),
                ],
              ),
            )
          ],
          body: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, EditSubCategoryScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _showEditOptions(context, cubit, state);
                },
                child: Stack(
                  alignment: Alignment(1, 1.2),
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      child: Icon(
                        IconData(
                          state.subCategory!.icon,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: AppColors.white,
                        size: 40,
                      ),
                      backgroundColor: Color(state.subCategory!.color),
                    ),
                    CircleAvatar(
                      maxRadius: 15,
                      child: Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 15,
                      ),
                      backgroundColor: AppColors.greySecondary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: state.subCategory!.name,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onChanged: (name) => cubit.onNameChanged(name),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditSubCategoryScreenCubit cubit,
  EditSubCategoryScreenState state,
) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Cambiar icono'),
          onPressed: () {
            Navigator.pop(context);
            _pickIcon(context, cubit);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Cambiar color'),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(context, cubit, state);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Cancelar',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}

Future _pickColor(
  BuildContext context,
  EditSubCategoryScreenCubit cubit,
  EditSubCategoryScreenState state,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        'Seleccionar color',
        textAlign: TextAlign.center,
      ),
      content: MaterialColorPicker(
        allowShades: false,
        selectedColor: Color(state.subCategory!.color),
        onMainColorChange: (colorSwatch) {
          cubit.onColorUpdated(colorSwatch!.value).then(
                (_) => Navigator.of(context).pop(),
              );
        },
      ),
    ),
  );
}

Future<void> _pickIcon(
  BuildContext context,
  EditSubCategoryScreenCubit cubit,
) async {
  final materialIcons = AppIcons.materialIcons();
  final icon = await FlutterIconPicker.showIconPicker(
    context,
    title: Text(
      'Selecionar icono',
      textAlign: TextAlign.center,
    ),
    iconPickerShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    searchHintText: 'Buscar',
    closeChild: Text('Cerrar'),
    iconSize: 30,
    customIconPack: materialIcons,
    iconColor: AppColors.black,
    iconPackModes: [IconPack.custom],
  );

  if (icon != null) {
    cubit.onIconUpdated(icon.codePoint);
  }
}

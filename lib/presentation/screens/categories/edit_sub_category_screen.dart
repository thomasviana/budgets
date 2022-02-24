import 'package:budgets/presentation/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
import '../../routes/app_navigator.dart';
import 'edit_sub_category_bloc/edit_sub_category_screen_bloc.dart';

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
  late EditSubCategoryScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<EditSubCategoryScreenBloc>()
      ..add(CheckSubCategory(subCategory: widget.subCategory));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSubCategoryScreenBloc, EditSubCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditSubCategoryScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: CupertinoPageScaffold(
          backgroundColor: AppColors.greyBackground,
          child: NestedScrollView(
            headerSliverBuilder: (ctx, inner) => [
              CupertinoSliverNavigationBar(
                largeTitle: Text('Subcategoría'),
                previousPageTitle: 'Atras',
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.red,
                      ),
                      onPressed: () {
                        bloc.add(SubCategoryDeleted());
                        AppNavigator.navigateBack(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        bloc.add(SubCategorySaved());
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
  }

  Widget _buildBody(BuildContext context, EditSubCategoryScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  _showEditOptions(context, bloc, state);
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                'GENERAL',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              color: AppColors.white,
              child: Column(
                children: [
                  Divider(height: 2),
                  ListTile(
                    leading: Icon(Icons.drive_file_rename_outline_outlined),
                    minLeadingWidth: 2,
                    title: Text('Nombre'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.subCategory!.name.isNotEmpty)
                          Text(
                            state.subCategory!.name,
                            style: TextStyle(color: AppColors.greySecondary),
                          ),
                        if (state.subCategory!.name.isEmpty)
                          Text(
                            'Requerido',
                            style: TextStyle(color: AppColors.red),
                          ),
                        SizedBox(width: 10),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                    onTap: () => AppNavigator.navigateToEditSubCategoryNamePage(
                      context,
                      name: state.subCategory!.name,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditSubCategoryScreenBloc bloc,
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
            _pickIcon(context, bloc);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Cambiar color'),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(context, bloc, state);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Cancelar',
          style: TextStyle(color: AppColors.red),
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
  EditSubCategoryScreenBloc bloc,
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
          bloc.add(ColorUpdated(colorSwatch!.value));
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

Future<void> _pickIcon(
  BuildContext context,
  EditSubCategoryScreenBloc bloc,
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
    bloc.add(IconUpdated(icon.codePoint));
  }
}

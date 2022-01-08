import 'package:budgets/presentation/resources/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_category_cubit/edit_category_screen_cubit.dart';

class EditCategoryScreen extends StatefulWidget {
  final Category? category;
  const EditCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);
  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late EditCategoryScreenCubit cubit;
  // late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditCategoryScreenCubit>();
    cubit.init(widget.category);
  }

  @override
  void dispose() {
    // textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryScreenCubit, EditCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditCategoryScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle:
                  Text(state.isEditMode ? 'Edit category' : 'Add category'),
              previousPageTitle: 'Back',
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.category?.id.value != 'housing' &&
                      state.category?.id.value != 'food' &&
                      state.category?.id.value != 'transportation' &&
                      state.category?.id.value != 'healthCare' &&
                      state.category?.id.value != 'services' &&
                      state.category?.id.value != 'recreation' &&
                      state.category?.id.value != 'shopping' &&
                      state.category?.id.value != 'financial')
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        cubit.onCategoryDeleted();
                        AppNavigator.navigateBack(context);
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      cubit.onCategorySaved(isNewCategory: !state.isEditMode);
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

  Widget _buildBody(BuildContext context, EditCategoryScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.white,
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
                              state.category!.icon,
                              fontFamily: 'MaterialIcons',
                            ),
                            color: AppColors.white,
                            size: 40,
                          ),
                          backgroundColor: Color(state.category!.color),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    // controller: textEditingController,
                    initialValue: state.isEditMode ? state.category!.name : '',
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                    autofocus: !state.isEditMode,
                    onChanged: (name) => cubit.onNameChanged(name),
                  ),
                ],
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
                'SUBCATEGORIES',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              color: AppColors.white,
              child: FutureBuilder(
                future: cubit.getUserSubCategories(),
                builder: (context, snapshot) {
                  final subCategories = state.subCategories ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    itemCount: subCategories.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(subCategories[index].name),
                        leading: CircleAvatar(
                          maxRadius: 20,
                          child: Icon(
                            IconData(
                              subCategories[index].icon,
                              fontFamily: 'MaterialIcons',
                            ),
                            color: AppColors.white,
                          ),
                          backgroundColor: Color(subCategories[index].color),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onTap: () {
                          AppNavigator.navigateToEditSubCategoryPage(
                            context,
                            subCategories[index],
                            (_) => cubit.getUserSubCategories(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Container(
              color: AppColors.white,
              child: ListTile(
                title: Text('Añadir subcategoria'),
                leading: CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  backgroundColor: AppColors.greyDisabled,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => cubit.onAddSubCategory(),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      );
    }
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditCategoryScreenCubit cubit,
  EditCategoryScreenState state,
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
  EditCategoryScreenCubit cubit,
  EditCategoryScreenState state,
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
        selectedColor: Color(state.category!.color),
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
  EditCategoryScreenCubit cubit,
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

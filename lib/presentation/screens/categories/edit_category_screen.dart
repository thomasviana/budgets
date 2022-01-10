import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
import '../../resources/colors.dart';
import '../../resources/icons.dart';
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
              largeTitle: Text(
                  state.isEditMode ? 'Editar categoria' : 'Crear categoria'),
              previousPageTitle: 'Atras',
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: InkWell(
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
                            if (state.category!.name.isNotEmpty)
                              Text(
                                state.category!.name,
                                style:
                                    TextStyle(color: AppColors.greySecondary),
                              ),
                            if (state.category!.name.isEmpty)
                              Text(
                                'Requerido',
                                style: TextStyle(color: Colors.red),
                              ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => _EditNameBottomSheet(
                              state: state,
                              onCancelPressed: () {},
                              onSavePressed: (name) {
                                cubit.onNameChanged(name);
                              },
                            ),
                          );
                        },
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
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        itemCount: subCategories.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(height: 2),
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
                              backgroundColor:
                                  Color(subCategories[index].color),
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
            )
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

class _EditNameBottomSheet extends HookWidget {
  final Function(String) onSavePressed;
  final VoidCallback onCancelPressed;
  final EditCategoryScreenState state;

  const _EditNameBottomSheet({
    Key? key,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController()
      ..text = state.category!.name;
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      AppNavigator.navigateBack(context);
                      onCancelPressed();
                    }),
                const Text(
                  'Editar categoria',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    AppNavigator.navigateBack(context);
                    onSavePressed(textEditingController.value.text.trim());
                  },
                ),
              ],
            ),
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
      ),
    );
  }
}

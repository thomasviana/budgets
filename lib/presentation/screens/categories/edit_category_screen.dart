import 'package:budgets/presentation/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
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

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditCategoryScreenCubit>()
      ..init(widget.category)
      ..getUserSubCategories();
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
                state.isEditMode ? 'Editar categoria' : 'Crear categoría',
              ),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!state.isDefaultExpenseCategory &&
                      !state.isDefaultIncomeCategory)
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.red,
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
                    title: Text(AppLocalizations.of(context)!.misc_name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.category!.name.isNotEmpty)
                          Text(
                            state.category!.name,
                            style: TextStyle(color: AppColors.greySecondary),
                          ),
                        if (state.category!.name.isEmpty)
                          Text(
                            'Requerido',
                            style: TextStyle(color: AppColors.red),
                          ),
                        SizedBox(width: 10),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                    onTap: () => AppNavigator.navigateToEditCategoryNamePage(
                      context,
                      name: state.category!.name,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.compare_outlined),
                    minLeadingWidth: 2,
                    title: Text('Tipo'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.category!.type == CategoryType.income
                              ? 'Categoria de Ingreso'
                              : 'Categoria de Egreso',
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                    onTap: () =>
                        AppNavigator.navigateToSelectCategoryTypePage(context),
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
              color: state.subCategories == null || state.subCategories!.isEmpty
                  ? null
                  : AppColors.white,
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
                          backgroundColor: Color(subCategories[index].color),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
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
                  Icons.chevron_right,
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

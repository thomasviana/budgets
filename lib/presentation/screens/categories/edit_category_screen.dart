import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/categories/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_category_bloc/edit_category_screen_bloc.dart';

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
  late EditCategoryScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<EditCategoryScreenBloc>()
      ..add(CheckCategory(category: widget.category))
      ..add(GetUserSubcategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryScreenBloc, EditCategoryScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditCategoryScreenState state) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(
                state.isEditMode ? 'Editar categoria' : 'Crear categoría',
              ),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: GestureDetector(
                child: Icon(
                  CupertinoIcons.checkmark_alt_circle,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                onTap: () {
                  bloc.add(CategorySaved());
                  AppNavigator.navigateBack(context);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Material(
                child: _buildBody(context, state),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            state.isEditMode ? 'Editar categoria' : 'Crear categoría',
          ),
          actions: [
            if (!state.isDefaultCategory)
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.red,
                ),
                onPressed: () {
                  bloc.add(CategoryDeleted());
                  AppNavigator.navigateBack(context);
                },
              ),
            IconButton(
              icon: Icon(
                Icons.check,
                color: AppColors.white,
              ),
              onPressed: () {
                bloc.add(CategorySaved());
                AppNavigator.navigateBack(context);
              },
            ),
          ],
        ),
        body: _buildBody(context, state),
      );
    }
  }

  Widget _buildBody(BuildContext context, EditCategoryScreenState state) {
    final subCategories = state.subCategories ?? [];

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
                      radius: 40,
                      backgroundColor: Color(state.category!.color),
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.white,
                        child: Icon(
                          IconData(
                            state.category!.icon,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: Color(state.category!.color),
                          size: 40,
                        ),
                      ),
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
            if (Platform.isAndroid) ...[
              SizedBox(height: 20),
              Divider(height: 2),
            ],
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
                        if (Platform.isIOS) const Icon(CupertinoIcons.forward),
                      ],
                    ),
                    onTap: () => AppNavigator.navigateToEditCategoryNamePage(
                      context,
                      name: state.category!.name,
                    ),
                  ),
                  if (!state.isEditMode)
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
                          if (Platform.isIOS)
                            const Icon(CupertinoIcons.forward),
                        ],
                      ),
                      onTap: () =>
                          AppNavigator.navigateToSelectCategoryTypePage(
                        context,
                      ),
                    ),
                ],
              ),
            ),
            if (Platform.isAndroid) Divider(height: 2),
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
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: subCategories.length == 1
                    ? EdgeInsets.zero
                    : EdgeInsets.only(top: 4, bottom: 4),
                itemCount:
                    subCategories.isNotEmpty ? subCategories.length - 1 : 0,
                separatorBuilder: (BuildContext context, int index) =>
                    Platform.isIOS
                        ? const Divider(height: 2)
                        : const SizedBox(),
                itemBuilder: (BuildContext context, int index) {
                  final subCategory = subCategories[index + 1];
                  return ListTile(
                    title: Text(subCategory.name),
                    leading: ListTileLeadingIcon(
                      icon: subCategory.icon,
                      color: subCategory.color,
                    ),
                    trailing: Platform.isIOS
                        ? const Icon(CupertinoIcons.forward)
                        : null,
                    onTap: () {
                      AppNavigator.navigateToEditSubCategoryPage(
                        context,
                        subCategory,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            if (Platform.isAndroid) Divider(height: 2),
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
                trailing:
                    Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
                onTap: () => bloc.add(SubcategoryAdded()),
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
  EditCategoryScreenBloc bloc,
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
  EditCategoryScreenBloc bloc,
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
          bloc.add(ColorUpdated(colorSwatch!.value));
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

Future<void> _pickIcon(
  BuildContext context,
  EditCategoryScreenBloc bloc,
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

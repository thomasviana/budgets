import 'package:budgets/core/accounts/domain.dart';
import 'package:budgets/presentation/resources/logos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_account_cubit/edit_account_screen_cubit.dart';

class EditAccountScreen extends StatefulWidget {
  final Account? account;
  const EditAccountScreen({
    Key? key,
    required this.account,
  }) : super(key: key);
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late EditAccountScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EditAccountScreenCubit>();
    cubit.init(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAccountScreenCubit, EditAccountScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditAccountScreenState state) {
    return Scaffold(
      body: CupertinoPageScaffold(
        backgroundColor: AppColors.greyBackground,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, inner) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Edit account'),
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
                      cubit.onAccountDeleted();
                      AppNavigator.navigateBack(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      cubit.onAccountSaved();
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

  Widget _buildBody(BuildContext context, EditAccountScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      NetworkImage? image;
      Icon? accountIcon;
      bool isImageAvailable;
      final account = state.account;

      if (account!.imageUrl != null) {
        isImageAvailable = true;
        image = NetworkImage(account.imageUrl!);
      } else {
        isImageAvailable = false;
        accountIcon = Icon(
          IconData(
            account.icon,
            fontFamily: 'MaterialIcons',
          ),
          size: 40,
          color: AppColors.white,
        );
      }
      return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      backgroundColor: Color(account.color),
                      backgroundImage: image,
                      child: isImageAvailable ? null : accountIcon,
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
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet_rounded),
                    title: Text('Nombre'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.account!.name,
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    minLeadingWidth: 2,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      IconData(
                        state.account!.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                    ),
                    title: Text('Tipo'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.account!.typeAsString,
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    minLeadingWidth: 2,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.attach_money_rounded),
                    title: Text('Balance'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$${currency.format(state.account!.balance)}',
                          style: TextStyle(color: AppColors.greySecondary),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    minLeadingWidth: 2,
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
  EditAccountScreenCubit cubit,
  EditAccountScreenState state,
) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Cambiar color'),
          onPressed: () {
            Navigator.pop(context);
            _pickColor(context, cubit, state);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Seleccionar logo'),
          onPressed: () {
            Navigator.pop(context);
            _pickImage(context, cubit, state);
          },
        ),
        if (state.account!.imageUrl != null)
          CupertinoActionSheetAction(
            child: Text(
              'Eliminar logo',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              cubit.onLogoDeleted();
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
  EditAccountScreenCubit cubit,
  EditAccountScreenState state,
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
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cerrar'),
        )
      ],
      content: MaterialColorPicker(
        allowShades: false,
        selectedColor: Color(state.account!.color),
        onMainColorChange: (colorSwatch) {
          cubit.onColorUpdated(colorSwatch!.value).then(
                (_) => Navigator.of(context).pop(),
              );
        },
      ),
    ),
  );
}

Future _pickImage(
  BuildContext context,
  EditAccountScreenCubit cubit,
  EditAccountScreenState state,
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
        'Seleccionar logo',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cerrar'),
        )
      ],
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width * .66,
        child: GridView.count(
          crossAxisCount: 4,
          padding: const EdgeInsets.all(6.0),
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: <String>[
            AccountDefaultLogos.bancolombia,
            AccountDefaultLogos.davivienda,
            AccountDefaultLogos.nuBank,
            AccountDefaultLogos.bbva,
            AccountDefaultLogos.falabella,
            AccountDefaultLogos.bancoDeBogota,
            AccountDefaultLogos.bancoDeOccidente,
            AccountDefaultLogos.avvillas,
            AccountDefaultLogos.scotiabank,
            AccountDefaultLogos.cajaSocial,
            AccountDefaultLogos.bankOfAmerica,
            AccountDefaultLogos.chase,
            AccountDefaultLogos.wellsFargo,
            AccountDefaultLogos.cash,
            AccountDefaultLogos.binance,
            AccountDefaultLogos.metamask,
          ]
              .map(
                (url) => InkWell(
                  onTap: () {
                    cubit.onLogoSelected(url);
                    Navigator.of(context).pop();
                  },
                  child: GridTile(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}

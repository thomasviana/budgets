// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

// import '../../../core/transactions/domain.dart';
// import '../../resources/colors.dart';
// import '../../routes/app_navigator.dart';
// import 'edit_transaction_cubit/edit_transaction_screen_cubit.dart';

// class EditTransactionScreen extends StatefulWidget {
//   final Transaction? transaction;
//   const EditTransactionScreen({
//     Key? key,
//     required this.transaction,
//   }) : super(key: key);
//   @override
//   _EditTransactionScreenState createState() => _EditTransactionScreenState();
// }

// class _EditTransactionScreenState extends State<EditTransactionScreen> {
//   late EditTransactionScreenCubit cubit;

//   @override
//   void initState() {
//     super.initState();
//     cubit = context.read<EditTransactionScreenCubit>();
//     cubit.init(widget.transaction);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EditTransactionScreenCubit, EditTransactionScreenState>(
//       builder: _buildState,
//     );
//   }

//   Widget _buildState(BuildContext context, EditTransactionScreenState state) {
//     return Scaffold(
//       body: CupertinoPageScaffold(
//         backgroundColor: AppColors.greyBackground,
//         child: NestedScrollView(
//           headerSliverBuilder: (ctx, inner) => [
//             CupertinoSliverNavigationBar(
//               largeTitle:
//                   Text(state.isEditMode ? 'Editar cuenta' : 'Crear cuenta'),
//               previousPageTitle: 'Atras',
//               trailing: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   if (state.transaction?.id.value != 'inv' &&
//                       state.transaction?.id.value != 'seg' &&
//                       state.transaction?.id.value != 'dar')
//                     IconButton(
//                       icon: Icon(
//                         Icons.delete_outline,
//                         color: Colors.red,
//                       ),
//                       onPressed: () {
//                         cubit.onTransactionDeleted();
//                         AppNavigator.navigateBack(context);
//                       },
//                     ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.check,
//                       color: AppColors.primaryColor,
//                     ),
//                     onPressed: () {
//                       if (state.transaction!.name.isEmpty) return;
//                       cubit.onTransactionSaved(
//                           isNewTransaction: !state.isEditMode);
//                       AppNavigator.navigateBack(context);
//                     },
//                   ),
//                 ],
//               ),
//             )
//           ],
//           body: _buildBody(context, state),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody(BuildContext context, EditTransactionScreenState state) {
//     if (state.isLoading) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       final transaction = state.transaction;
//       bool hasAbbreviation = true;
//       if (transaction!.abbreviation == null ||
//           transaction.abbreviation!.isEmpty) {
//         hasAbbreviation = false;
//       }
//       return Container(
//         alignment: Alignment.center,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   _showEditOptions(context, cubit, state);
//                 },
//                 child: Stack(
//                   alignment: Alignment(1, 1.2),
//                   children: [
//                     CircleAvatar(
//                       maxRadius: 40,
//                       backgroundColor: Color(state.transaction!.color),
//                       child: hasAbbreviation
//                           ? Text(
//                               transaction.abbreviation!,
//                               style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.white,
//                               ),
//                             )
//                           : Icon(
//                               Icons.inbox,
//                               color: AppColors.white,
//                               size: 40,
//                             ),
//                     ),
//                     CircleAvatar(
//                       maxRadius: 15,
//                       child: Icon(
//                         Icons.edit,
//                         color: AppColors.white,
//                         size: 15,
//                       ),
//                       backgroundColor: AppColors.greySecondary,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: kDefaultPadding,
//                 left: kDefaultPadding,
//                 right: kDefaultPadding,
//                 bottom: 8,
//               ),
//               child: Text(
//                 'GENERAL',
//                 style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//             Container(
//               color: AppColors.white,
//               child: Column(
//                 children: [
//                   Divider(height: 2),
//                   ListTile(
//                     leading: Icon(Icons.drive_file_rename_outline_outlined),
//                     minLeadingWidth: 2,
//                     title: Text('Nombre'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (state.transaction!.name.isNotEmpty)
//                           Text(
//                             state.transaction!.name,
//                             style: TextStyle(color: AppColors.greySecondary),
//                           ),
//                         if (state.transaction!.name.isEmpty)
//                           Text(
//                             'Requerido',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         SizedBox(width: 10),
//                         Icon(Icons.arrow_forward_ios_rounded)
//                       ],
//                     ),
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (context) => _EditNameBottomSheet(
//                           state: state,
//                           onCancelPressed: () {},
//                           onSavePressed: (name) {
//                             cubit.onNameChanged(name);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   Divider(height: 2),
//                   ListTile(
//                     leading: Icon(Icons.inbox),
//                     minLeadingWidth: 2,
//                     title: Text('Abreviatura'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           state.transaction!.abbreviation ?? '',
//                           style: TextStyle(color: AppColors.greySecondary),
//                         ),
//                         SizedBox(width: 10),
//                         Icon(Icons.arrow_forward_ios_rounded)
//                       ],
//                     ),
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (context) => _EditAbbreviationBottomSheet(
//                           state: state,
//                           onCancelPressed: () {},
//                           onSavePressed: (abbrevation) {
//                             cubit.onAbbreviationChanged(abbrevation);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   Divider(height: 2),
//                   ListTile(
//                     leading: Icon(Icons.attach_money_rounded),
//                     minLeadingWidth: 2,
//                     title: Text('Balance'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           '\$${currency.format(state.transaction!.balance)}',
//                           style: TextStyle(color: AppColors.greySecondary),
//                         ),
//                         SizedBox(width: 10),
//                         Icon(Icons.arrow_forward_ios_rounded)
//                       ],
//                     ),
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (context) => _EditBalanceBottomSheet(
//                           state: state,
//                           onCancelPressed: () {},
//                           onSavePressed: (balance) {
//                             cubit.onBalanceChanged(balance);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   Divider(height: 2),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

// Future<void> _showEditOptions(
//   BuildContext context,
//   EditTransactionScreenCubit cubit,
//   EditTransactionScreenState state,
// ) async {
//   await showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoActionSheet(
//       actions: <CupertinoActionSheetAction>[
//         CupertinoActionSheetAction(
//           child: const Text('Cambiar color'),
//           onPressed: () {
//             Navigator.pop(context);
//             _pickColor(context, cubit, state);
//           },
//         ),
//       ],
//       cancelButton: CupertinoActionSheetAction(
//         child: const Text(
//           'Cancelar',
//           style: TextStyle(color: Colors.red),
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     ),
//   );
// }

// Future _pickColor(
//   BuildContext context,
//   EditTransactionScreenCubit cubit,
//   EditTransactionScreenState state,
// ) {
//   return showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(16),
//         ),
//       ),
//       title: Text(
//         'Seleccionar color',
//         textAlign: TextAlign.center,
//       ),
//       actions: [
//         TextButton(
//           onPressed: Navigator.of(context).pop,
//           child: Text('Cerrar'),
//         )
//       ],
//       content: MaterialColorPicker(
//         allowShades: false,
//         selectedColor: Color(state.transaction!.color),
//         onMainColorChange: (colorSwatch) {
//           cubit.onColorUpdated(colorSwatch!.value).then(
//                 (_) => Navigator.of(context).pop(),
//               );
//         },
//       ),
//     ),
//   );
// }

// class _EditNameBottomSheet extends HookWidget {
//   final Function(String) onSavePressed;
//   final VoidCallback onCancelPressed;
//   final EditTransactionScreenState state;

//   const _EditNameBottomSheet({
//     Key? key,
//     required this.onSavePressed,
//     required this.onCancelPressed,
//     required this.state,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final textEditingController = useTextEditingController()
//       ..text = state.transaction!.name;
//     return DraggableScrollableSheet(
//       initialChildSize: 0.95,
//       maxChildSize: 0.95,
//       builder: (context, controller) => Container(
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                     child: const Text('Cancelar'),
//                     onPressed: () {
//                       AppNavigator.navigateBack(context);
//                       onCancelPressed();
//                     }),
//                 const Text(
//                   'Editar cuenta',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 TextButton(
//                   child: const Text('Guardar'),
//                   onPressed: () {
//                     AppNavigator.navigateBack(context);
//                     onSavePressed(textEditingController.value.text.trim());
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             TextField(
//               controller: textEditingController,
//               keyboardType: TextInputType.name,
//               autofocus: true,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               decoration: InputDecoration(
//                 alignLabelWithHint: true,
//                 label: Center(
//                   child: Text(
//                     'Nuevo nombre',
//                   ),
//                 ),
//                 labelStyle: TextStyle(
//                   color: AppColors.black,
//                   fontWeight: FontWeight.w300,
//                   fontSize: 14,
//                 ),
//                 hintStyle: TextStyle(fontSize: 18),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 hintText: '',
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EditAbbreviationBottomSheet extends HookWidget {
//   final Function(String) onSavePressed;
//   final VoidCallback onCancelPressed;
//   final EditTransactionScreenState state;

//   const _EditAbbreviationBottomSheet({
//     Key? key,
//     required this.onSavePressed,
//     required this.onCancelPressed,
//     required this.state,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final textEditingController = useTextEditingController()
//       ..text = state.transaction!.abbreviation ?? '';
//     return DraggableScrollableSheet(
//       initialChildSize: 0.95,
//       maxChildSize: 0.95,
//       builder: (context, controller) => Container(
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   child: const Text('Cancelar'),
//                   onPressed: () {
//                     AppNavigator.navigateBack(context);
//                     onCancelPressed();
//                   },
//                 ),
//                 const Text(
//                   'Editar cuenta',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 TextButton(
//                   child: const Text('Guardar'),
//                   onPressed: () {
//                     onSavePressed(textEditingController.value.text.trim());
//                     AppNavigator.navigateBack(context);
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             TextField(
//               controller: textEditingController,
//               keyboardType: TextInputType.name,
//               autofocus: true,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLength: 3,
//               decoration: InputDecoration(
//                 alignLabelWithHint: true,
//                 label: Center(
//                   child: Text(
//                     'Nueva abreviatura',
//                   ),
//                 ),
//                 labelStyle: TextStyle(
//                   color: AppColors.black,
//                   fontWeight: FontWeight.w300,
//                   fontSize: 14,
//                 ),
//                 hintStyle: TextStyle(fontSize: 18),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 hintText: '',
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EditBalanceBottomSheet extends HookWidget {
//   final Function(double) onSavePressed;
//   final VoidCallback onCancelPressed;
//   final EditTransactionScreenState state;

//   const _EditBalanceBottomSheet({
//     Key? key,
//     required this.onSavePressed,
//     required this.onCancelPressed,
//     required this.state,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final CurrencyTextInputFormatter _formatter =
//         CurrencyTextInputFormatter(symbol: '\$');
//     final textEditingController = useTextEditingController()
//       ..text = _formatter.format(state.transaction!.balance.toString());

//     return DraggableScrollableSheet(
//       initialChildSize: 0.95,
//       maxChildSize: 0.95,
//       builder: (context, controller) => Container(
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                     child: const Text('Cancelar'),
//                     onPressed: () {
//                       AppNavigator.navigateBack(context);
//                       onCancelPressed();
//                     }),
//                 const Text(
//                   'Editar cuenta',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 TextButton(
//                   child: const Text('Guardar'),
//                   onPressed: () {
//                     final balance = _formatter.getUnformattedValue();
//                     onSavePressed(balance.toDouble());
//                     AppNavigator.navigateBack(context);
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             TextField(
//               controller: textEditingController,
//               inputFormatters: [_formatter],
//               keyboardType: TextInputType.name,
//               autofocus: true,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               decoration: InputDecoration(
//                 alignLabelWithHint: true,
//                 label: Center(
//                   child: Text(
//                     'Nuevo balance',
//                   ),
//                 ),
//                 labelStyle: TextStyle(
//                   color: AppColors.black,
//                   fontWeight: FontWeight.w300,
//                   fontSize: 14,
//                 ),
//                 hintStyle: TextStyle(fontSize: 18),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 hintText: '\$${currency.format(0)}',
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

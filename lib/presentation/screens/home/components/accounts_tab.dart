import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../widgets/account_tile.dart';
import '../../../widgets/rounded_button.dart';

class AccountsTab extends StatelessWidget {
  const AccountsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBackground,
      child: Column(
        children: [
          AccountTile(
            title: 'Bancolombia',
            amount: '\$0,00',
            subtitle: 'Cuenta de ahorros',
            assetPath:
                'https://www.agenciacma.com.br/wp-content/uploads/2021/05/Logo-Bancolombia.png',
          ),
          AccountTile(
            title: 'Davivienda',
            amount: '\$0,00',
            subtitle: 'Cuenta de ahorros',
            assetPath:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6fbpgj1z1CTryo5j6lK2v3ykblXuXTb6cww&usqp=CAU',
          ),
          AccountTile(
            title: 'Cash',
            amount: '\$0,00',
            subtitle: 'Cuenta de ahorros',
            assetPath: 'https://www.csvtasaciones.com/images/cash-icon.png',
          ),
          AccountTile(
            title: 'Wallet',
            amount: '\$0,00',
            subtitle: 'Cuenta de ahorros',
            assetPath:
                'https://key0.cc/images/small/2094654_2dc039cda7162bcb6775be62bc1068cd.png',
          ),
          SizedBox(height: 20),
          RoundedButton(
            onPressed: () {},
            label: 'Manage accounts',
            isEnabled: true,
          ),
        ],
      ),
    );
  }
}

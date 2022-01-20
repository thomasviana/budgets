import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final String assetPath;

  const AccountTile({
    Key? key,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        backgroundImage: NetworkImage(assetPath),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(subtitle),
      trailing: Text(amount),
      onTap: () {},
    );
  }
}

import 'package:budgets/constants.dart';
import 'package:budgets/widgets/transaction_listtile.dart';
import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        width: size.width - kDefaultPadding * 2,
        height: 300,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last Records',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                )
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TransactionListTile(),
                  TransactionListTile(),
                  TransactionListTile(),
                  Spacer(),
                  Text('Show more',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.blue))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

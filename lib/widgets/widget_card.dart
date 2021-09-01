import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        width: 400,
        height: 300,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last Records',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              margin: EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              height: 200,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

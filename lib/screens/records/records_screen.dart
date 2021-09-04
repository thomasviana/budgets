import 'package:flutter/cupertino.dart';

class RecordsScreen extends StatelessWidget {
  static const routeName = '/records-screen';
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Records'),
          ),
        ],
        body: Container(),
      ),
    );
  }
}

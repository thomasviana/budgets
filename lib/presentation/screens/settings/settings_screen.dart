import 'package:flutter/cupertino.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/settings-screen';
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
        ],
        body: Container(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../constants.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: kPrimayColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_on,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

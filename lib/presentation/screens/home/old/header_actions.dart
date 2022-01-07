import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/colors.dart';

class HeaderActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: AppColors.primaryColor,
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

import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        'B u d g e t s',
        style: TextStyle(color: AppColors.white),
      ),
      pinned: true,
      leading: Row(
        children: const [
          SizedBox(width: 16),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.greyDisabled,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_on,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

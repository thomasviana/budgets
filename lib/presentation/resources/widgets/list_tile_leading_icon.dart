import 'package:flutter/material.dart';

import '../resources.dart';

class ListTileLeadingIcon extends StatelessWidget {
  final int icon;
  final int color;

  const ListTileLeadingIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(color),
      radius: 20,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.white,
        child: Icon(
          IconData(
            icon,
            fontFamily: 'MaterialIcons',
          ),
          color: Color(color),
        ),
      ),
    );
  }
}

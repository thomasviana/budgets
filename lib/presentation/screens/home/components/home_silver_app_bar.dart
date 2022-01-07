import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class HomeSliverAppBar extends StatelessWidget {
  final String title;

  const HomeSliverAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
      pinned: true,
      backgroundColor: AppColors.primaryColor,
      expandedHeight: 210,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: const [
                AppColors.primaryColor,
                AppColors.primaryVariant,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Balance',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(height: 5),
              Text(
                '\$0,00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddButton(
                    text: 'Income',
                    iconData: Icons.arrow_downward,
                    onPressed: () {},
                  ),
                  SizedBox(width: 25),
                  AddButton(
                    text: 'Expense',
                    iconData: Icons.arrow_upward,
                    onPressed: () {},
                  ),
                  SizedBox(width: 25),
                  AddButton(
                    text: 'Asset',
                    iconData: Icons.query_stats,
                    onPressed: () {},
                  ),
                  SizedBox(width: 25),
                  AddButton(
                    text: 'Debt',
                    iconData: Icons.grading_sharp,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const AddButton({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(iconData),
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: AppColors.white, fontSize: 10),
        ),
      ],
    );
  }
}

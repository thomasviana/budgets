import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';

class WidgetCard extends StatelessWidget {
  final String title;
  final Widget content;

  const WidgetCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Card(
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
                    title,
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
              content,
            ],
          ),
        ),
      ),
    );
  }
}

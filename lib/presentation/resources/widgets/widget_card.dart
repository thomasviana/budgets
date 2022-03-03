import 'package:flutter/material.dart';

import '../resources.dart';

class WidgetCard extends StatelessWidget {
  final String title;
  final String actionTitle;
  final VoidCallback onActionPressed;
  final Widget content;

  const WidgetCard({
    Key? key,
    required this.title,
    required this.actionTitle,
    required this.onActionPressed,
    required this.content,
  }) : super(key: key);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    child: Text(actionTitle),
                    onPressed: onActionPressed,
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

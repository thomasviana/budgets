import 'package:budgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SliverToBoxAdapter statCard(
  BuildContext context, {
  required String title,
  required double amount,
  required Widget graph,
}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$ ${currency.format(amount)}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              graph,
            ],
          ),
        ),
      ),
    ),
  );
}

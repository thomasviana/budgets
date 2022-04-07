import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../../../utils/observer.dart';
import '../home_bloc/home_screen_bloc.dart';

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
      leading: Platform.isIOS
          ? Row(
              children: [
                SizedBox(width: 16),
                Observer<HomeScreenBloc, HomeScreenState>(
                  onSuccess: (context, state) {
                    final user = state.user;
                    Widget? image;

                    if (user.imagePath != null) {
                      image = Image.file(
                        File(user.imagePath!),
                        fit: BoxFit.cover,
                      );
                    } else if (user.photoUrl != null) {
                      image = CachedNetworkImage(
                        imageUrl: user.photoUrl!,
                        progressIndicatorBuilder: (_, __, progress) =>
                            CircularProgressIndicator(value: progress.progress),
                        errorWidget: (_, __, ___) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    }
                    return InkWell(
                      onTap: () => AppNavigator.navigateToProfilePage(context),
                      child: ClipOval(
                        // ignore: sized_box_for_whitespace
                        child: Container(height: 32, width: 32, child: image),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_on,
            color: Colors.white,
          ),
        ),
        if (Platform.isAndroid)
          Observer<HomeScreenBloc, HomeScreenState>(
            onSuccess: (context, state) {
              final user = state.user;
              Widget? image;

              if (user.imagePath != null) {
                image = Image.file(
                  File(user.imagePath!),
                  fit: BoxFit.cover,
                );
              } else if (user.photoUrl != null) {
                image = CachedNetworkImage(
                  imageUrl: user.photoUrl!,
                  progressIndicatorBuilder: (_, __, progress) =>
                      CircularProgressIndicator(value: progress.progress),
                  errorWidget: (_, __, ___) => Icon(Icons.error),
                  fit: BoxFit.cover,
                );
              }
              return InkWell(
                onTap: () => AppNavigator.navigateToProfilePage(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: image,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

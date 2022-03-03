import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/auth/auth_bloc.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.userEntity;
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

    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        'B u d g e t s',
        style: TextStyle(color: AppColors.white),
      ),
      pinned: true,
      leading: Row(
        children: [
          SizedBox(width: 16),
          InkWell(
            onTap: () => AppNavigator.navigateToProfilePage(context),
            child: ClipOval(
              // ignore: sized_box_for_whitespace
              child: Container(height: 32, width: 32, child: image),
            ),
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

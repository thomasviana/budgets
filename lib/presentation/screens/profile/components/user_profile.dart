import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/account.dart';
import '../../../resources/colors.dart';
import '../../../widgets/rounded_button.dart';
import '../cubit/profile_screen_cubit.dart';

class UserProfile extends StatefulWidget {
  final UserEntity user;
  final bool isSavingForm;
  final bool isSaveButtonEnabled;

  const UserProfile({
    Key? key,
    // this.pickedImage,
    required this.user,
    required this.isSavingForm,
    required this.isSaveButtonEnabled,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Widget? image;

    if (widget.user.imagePath != null) {
      print('path error');
      image = Image.file(
        File(widget.user.imagePath!),
        fit: BoxFit.cover,
      );
    } else if (widget.user.photoUrl != null) {
      print('url error');
      image = CachedNetworkImage(
        imageUrl: widget.user.photoUrl!,
        progressIndicatorBuilder: (_, __, progress) =>
            CircularProgressIndicator(value: progress.progress),
        errorWidget: (_, __, ___) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              InkWell(
                onTap: context.read<ProfileScreenCubit>().onPickImage,
                child: ClipOval(
                  // ignore: sized_box_for_whitespace
                  child: Container(height: 150, width: 150, child: image),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'User ID: ${widget.user.id.value}',
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.user.name!.value,
                      decoration: InputDecoration(labelText: 'Name'),
                      keyboardType: TextInputType.name,
                      onChanged: (name) => context
                          .read<ProfileScreenCubit>()
                          .onNameChanged(name),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: widget.user.emailAddress.value,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      initialValue: widget.user.phoneNumber!.value,
                      decoration: InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      onChanged: (phone) => context
                          .read<ProfileScreenCubit>()
                          .onPhoneChanged(phone),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              if (widget.isSavingForm)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (!widget.isSavingForm)
                RoundedButton(
                  label: 'Save',
                  isEnabled: widget.isSaveButtonEnabled,
                  onPressed: () {
                    context.read<ProfileScreenCubit>().onUpdateUserInfo();
                  },
                ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

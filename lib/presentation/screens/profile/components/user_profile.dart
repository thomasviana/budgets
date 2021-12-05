import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/account.dart';
import '../../../resources/colors.dart';
import '../../../widgets/rounded_button.dart';
import '../cubit/profile_screen_cubit.dart';

class UserProfile extends StatelessWidget {
  final UserEntity user;
  final bool isSavingForm;

  UserProfile({
    Key? key,
    // this.pickedImage,
    required this.user,
    required this.isSavingForm,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? _nameField;
    String? _emailField;
    String? _phoneField;
    Widget? image;

    if (user.imagePath != null) {
      image = Image.file(File(user.imagePath!.getOrCrash()), fit: BoxFit.cover);
    } else if (user.photoUrl != null) {
      image = CachedNetworkImage(
        imageUrl: user.photoUrl!,
        progressIndicatorBuilder: (_, __, progress) =>
            CircularProgressIndicator(value: progress.progress),
        errorWidget: (_, __, ___) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }

    return SingleChildScrollView(
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
                'User ID: ${user.id.getOrCrash()}',
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        initialValue: user.name!.getOrCrash(),
                        decoration: InputDecoration(labelText: 'Name'),
                        onSaved: (value) {
                          _nameField = value;
                        }),
                    TextFormField(
                        enabled: false,
                        initialValue: user.emailAddress!.getOrCrash(),
                        decoration: InputDecoration(labelText: 'Email'),
                        onSaved: (value) {
                          _emailField = value;
                        }),
                    TextFormField(
                        initialValue: user.phoneNumber!.getOrCrash(),
                        decoration: InputDecoration(labelText: 'Phone'),
                        onSaved: (value) {
                          _phoneField = value;
                        }),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (isSavingForm)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (!isSavingForm)
                RoundedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    context
                        .read<ProfileScreenCubit>()
                        .onUpdateUserInfo(_nameField, _phoneField);
                  },
                  label: 'Save',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

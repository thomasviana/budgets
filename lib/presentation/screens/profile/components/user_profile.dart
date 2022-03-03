import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/user/domain.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../cubit/profile_screen_cubit.dart';

class UserProfile extends StatefulWidget {
  final UserEntity user;
  final bool isSavingForm;
  final bool isSaveButtonEnabled;

  const UserProfile({
    Key? key,
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
      image = Image.file(
        File(widget.user.imagePath!),
        fit: BoxFit.cover,
      );
    } else if (widget.user.photoUrl != null) {
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
              const SizedBox(height: 12),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.user.name!.value,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.misc_name,
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (name) => context
                          .read<ProfileScreenCubit>()
                          .onNameChanged(name),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: widget.user.emailAddress.value,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.misc_email,
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.user.phoneNumber!.value,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.misc_phone,
                      ),
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
                    context.read<ProfileScreenCubit>().onUpdateUserInfo().then(
                          (value) => AppNavigator.navigateBack(context),
                        );
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

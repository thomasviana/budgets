import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../../../utils/observer.dart';
import '../profile_screen_bloc/profile_sceen_bloc.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileScreenBloc, ProfileScreenState>(
      listener: (context, state) {
        if (state.formStatus == FormStatus.done) {
          AppNavigator.navigateBack(context);
        }
      },
      child: Observer<ProfileScreenBloc, ProfileScreenState>(
        onSuccess: (context, state) {
          final user = state.user!;
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
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  InkWell(
                    onTap: () =>
                        context.read<ProfileScreenBloc>().add(ImagePicked()),
                    child: ClipOval(
                      child: SizedBox(height: 150, width: 150, child: image),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(user.id.value),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: user.name!.value,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.misc_name,
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (name) => context
                              .read<ProfileScreenBloc>()
                              .add(NameChanged(name: name)),
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: user.emailAddress.value,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.misc_email,
                          ),
                        ),
                        TextFormField(
                          initialValue: user.phoneNumber!.value,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.misc_phone,
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: (phone) => context
                              .read<ProfileScreenBloc>()
                              .add(PhoneChanged(phone: phone)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
                    builder: (context, state) {
                      if (state.formStatus == FormStatus.saving) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.formStatus == FormStatus.saved) {
                        return AnimatedCheck();
                      } else {
                        return RoundedButton(
                          label: 'Save',
                          isEnabled: state.isSaveButtonEnabled,
                          onPressed: () {
                            context
                                .read<ProfileScreenBloc>()
                                .add(ProfileInfoUpdated());
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

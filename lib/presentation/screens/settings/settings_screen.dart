import 'dart:io';

import 'package:budgets/constants.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/bloc/cubit/user_cubit.dart';
import 'package:budgets/src/models/user_model.dart';
import 'package:budgets/src/repository/implementation/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(UserRepository())..getUser(),
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Seetings'),
            ),
          ],
          body: BlocBuilder<UserCubit, UserState>(
            builder: (_, state) {
              if (state is UserLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserReadyState) {
                return Column(
                  children: [
                    UserProfile(
                      user: state.user,
                      pickedImage: state.pickedImage,
                      isSaving: state.isSaving,
                    ),
                    Container(
                      child: TextButton.icon(
                        onPressed: () {
                          context.read<AuthCubit>().signOut();
                        },
                        icon: Icon(Icons.logout),
                        label: Text('Logout'),
                      ),
                    ),
                  ],
                );
              }
              throw Exception();
            },
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  final UserModel user;
  final File? pickedImage;
  final isSaving;

  const UserProfile({
    required this.user,
    this.pickedImage,
    this.isSaving,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _picker = ImagePicker();
  var image = Image.asset(
    'assets/images/profile_photo.jpg',
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.pickedImage != null) {
      image = Image.file(widget.pickedImage!, fit: BoxFit.fill);
    }

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedImage =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  context.read<UserCubit>().setImage(File(pickedImage.path));
                }
              },
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

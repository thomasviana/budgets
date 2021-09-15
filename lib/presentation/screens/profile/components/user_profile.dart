import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:budgets/data/models/user_model.dart';
import 'package:budgets/presentation/widgets/rounded_button.dart';
import 'package:budgets/src/bloc/cubit/auth_cubit.dart';
import 'package:budgets/src/bloc/cubit/user_cubit.dart';

import '../../../../constants.dart';

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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late Widget image;

  Future<void> pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      context.read<UserCubit>().setImage(File(pickedImage.path));
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = context.watch<UserCubit>().state is UserLoadingState;

    final userData = (context.read<AuthCubit>().state as AuthSignedIn).user;
    final imageUrl = userData.image;

    // image = CachedNetworkImage(
    //   imageUrl: imageUrl ?? widget.user.image!,
    //   progressIndicatorBuilder: (_, __, progress) =>
    //       CircularProgressIndicator(value: progress.progress),
    //   errorWidget: (_, __, ___) => Icon(Icons.error),
    //   fit: BoxFit.cover,
    // );
    if (widget.pickedImage != null) {
      image = Image.file(widget.pickedImage!, fit: BoxFit.cover);
    } else if (widget.user.image != null && widget.user.image!.isNotEmpty) {
      image = CachedNetworkImage(
        imageUrl: imageUrl ?? widget.user.image!,
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
                onTap: pickImage,
                child: ClipOval(
                  child: Container(height: 150, width: 150, child: image),
                ),
              ),
              SizedBox(height: 50),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (_, current) => current is AuthSignedIn,
                builder: (_, state) {
                  return Text(
                    'User ID: ${(state as AuthSignedIn).user.uid}',
                  );
                },
              ),
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: userData.name,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: userData.email,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      initialValue: userData.phone,
                      decoration: InputDecoration(labelText: 'Phone'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is UserReadyState) {
                    return RoundedButton(
                      onPressed: widget.isSaving
                          ? () {}
                          : () {
                              context.read<UserCubit>().saveUser(
                                    (context.read<AuthCubit>().state
                                            as AuthSignedIn)
                                        .user
                                        .uid,
                                    _nameController.text,
                                    _emailController.text,
                                    _phoneController.text,
                                  );
                            },
                      label: 'Save',
                    );
                  }
                  throw Exception();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

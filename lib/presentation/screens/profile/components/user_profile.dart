import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../application/auth.dart';
import '../../../../domain/auth.dart';
import '../../../resources/constants.dart';
import '../../../widgets/rounded_button.dart';

class UserProfile extends StatefulWidget {
  final UserModel user;
  final File? pickedImage;

  const UserProfile({
    required this.user,
    this.pickedImage,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late Widget image;
  late String? _imageUrl;

  Future<void> pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      // ignore: use_build_context_synchronously
      context.read<UserCubit>().setImage(File(pickedImage.path));
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSavingForm = context.watch<UserCubit>().state is UserLoadingState;
    final authUserData =
        (context.watch<AuthCubit>().state as AuthSignedIn).user;
    final userModelData =
        (context.watch<UserCubit>().state as UserReadyState).user;
    String? _nameField;
    String? _emailField;
    String? _phoneField;

    if (authUserData.image != null) {
      _imageUrl = authUserData.image;
    } else if (widget.user.image != null) {
      _imageUrl = widget.user.image;
    } else {
      _imageUrl =
          'https://thumbs.dreamstime.com/b/vector-de-usuario-redes-sociales-perfil-avatar-predeterminado-retrato-vectorial-del-176194876.jpg';
    }

    if (widget.pickedImage != null) {
      image = Image.file(widget.pickedImage!, fit: BoxFit.cover);
    } else if (_imageUrl != null) {
      image = CachedNetworkImage(
        imageUrl: _imageUrl!,
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
                  // ignore: sized_box_for_whitespace
                  child: Container(height: 150, width: 150, child: image),
                ),
              ),
              SizedBox(height: 50),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (_, current) => current is AuthSignedIn,
                builder: (_, state) {
                  // ignore: avoid_print
                  print(userModelData.name);
                  // ignore: avoid_print
                  print(authUserData.name);
                  return Text(
                    'User ID: ${(state as AuthSignedIn).user.uid}',
                  );
                },
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        initialValue: authUserData.name ?? userModelData.name,
                        decoration: InputDecoration(labelText: 'Name'),
                        onSaved: (value) {
                          _nameField = value;
                          print(_nameField);
                        }),
                    TextFormField(
                        enabled: false,
                        initialValue: authUserData.email ?? userModelData.email,
                        decoration: InputDecoration(labelText: 'Email'),
                        onSaved: (value) {
                          _emailField = value;
                        }),
                    TextFormField(
                        initialValue:
                            authUserData.phone ?? userModelData.phoneNumber,
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
                    // ignore: avoid_print
                    print(userModelData.name);
                    // ignore: avoid_print
                    print(authUserData.name);
                    context.read<UserCubit>().saveUser(
                          (context.read<AuthCubit>().state as AuthSignedIn)
                              .user
                              .uid,
                          _nameField,
                          _emailField,
                          _phoneField,
                        );
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

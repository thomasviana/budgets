import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../application/account.dart';
import '../../../../application/src/account/set_user_image.dart';
import '../../../../application/src/account/update_user_info.dart';
import '../../../../domain/account.dart';

part 'profile_screen_state.dart';

@injectable
class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  CheckAuthStatus checkAuthStatus;
  GetProfileInfo getProfileInfo;
  UpdateUserInfo updateUserInfo;
  SetUserImage setUserImage;

  ProfileScreenCubit(
    this.checkAuthStatus,
    this.getProfileInfo,
    this.updateUserInfo,
    this.setUserImage,
  ) : super(ProfileScreenState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final displayName = await getProfileInfo();
    displayName.fold(
      () => null,
      (user) => emit(state.copyWith(
        userEntity: user,
        isLoading: false,
      )),
    );
  }

  Future<void> onPickImage() async {
    final _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    print('pickimage: ${pickedImage.path}');

    _onImageChanged(pickedImage.path);

    emit(state.copyWith(isSavingForm: true));
    await setUserImage(state.userEntity);
    emit(state.copyWith(isSavingForm: false));
  }

  void _onImageChanged(String userImagePath) => emit(
        state.copyWith(
          userEntity:
              state.userEntity.copyWith(imagePath: ImagePath(userImagePath)),
        ),
      );

  Future<void> onUpdateUserInfo(String? name, String? phone) async {
    emit(state.copyWith(isSavingForm: true));
    _onNameChanged(name ?? state.userEntity.name!.getOrCrash());
    _onPhoneChanged(phone ?? state.userEntity.phoneNumber!.getOrCrash());
    await updateUserInfo(state.userEntity);
    emit(state.copyWith(isSavingForm: false));
  }

  void _onNameChanged(String name) => emit(state.copyWith(
        userEntity: state.userEntity.copyWith(name: UserName(name)),
      ));

  void _onPhoneChanged(String phone) => emit(state.copyWith(
        userEntity: state.userEntity.copyWith(phoneNumber: PhoneNumber(phone)),
      ));
}

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/account/application.dart';
import '../../../../core/account/domain.dart';

part 'profile_screen_state.dart';

@injectable
class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  CheckAuthStatus checkAuthStatus;
  GetProfileInfo getProfileInfo;
  UpdateUserInfo updateUserInfo;
  PickUserImage pickUserImage;

  ProfileScreenCubit(
    this.checkAuthStatus,
    this.getProfileInfo,
    this.updateUserInfo,
    this.pickUserImage,
  ) : super(ProfileScreenState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final displayName = await getProfileInfo();
    displayName.fold(
      () => emit(
        state.copyWith(
          userEntity: UserEntity.empty(),
          isLoading: false,
        ),
      ),
      (user) => emit(
        state.copyWith(
          userEntity: user,
          isLoading: false,
        ),
      ),
    );
  }

  void onNameChanged(String? name) => emit(
        state.copyWith(
          userEntity: state.userEntity..updateName(name),
          isSaveButtonEnabled: true,
        ),
      );

  void onPhoneChanged(String? phone) => emit(
        state.copyWith(
          userEntity: state.userEntity..updatePhoneNumber(phone),
          isSaveButtonEnabled: true,
        ),
      );

  Future<void> onPickImage() async {
    final pickedImage = await pickUserImage();
    pickedImage.fold(
      () => null,
      (image) => {
        _onImageChanged(image.path),
        emit(
          state.copyWith(
            isSavingForm: false,
            isSaveButtonEnabled: true,
          ),
        ),
      },
    );
  }

  void _onImageChanged(String userImagePath) => emit(
        state.copyWith(
          userEntity: state.userEntity..updateImagePath(userImagePath),
        ),
      );

  Future<void> onUpdateUserInfo() async {
    emit(state.copyWith(isSavingForm: true));
    await updateUserInfo(state.userEntity);
    emit(
      state.copyWith(
        isSavingForm: false,
        isSaveButtonEnabled: false,
      ),
    );
  }
}

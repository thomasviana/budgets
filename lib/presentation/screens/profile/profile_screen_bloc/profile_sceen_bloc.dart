import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/user/application.dart';
import '../../../../core/user/domain.dart';
import '../../../utils/observer.dart';

part 'profile_sceen_event.dart';
part 'profile_sceen_state.dart';

@injectable
class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final GetProfileInfo getProfileInfo;
  final UpdateUserInfo updateUserInfo;
  final PickUserImage pickUserImage;

  ProfileScreenBloc(
    this.getProfileInfo,
    this.updateUserInfo,
    this.pickUserImage,
  ) : super(ProfileScreenState.initial()) {
    on<ProfileInfoSuscriptionRequested>(_onProfileInfoSuscriptionRequested);
    on<NameChanged>(_onNameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<ImagePicked>(_onImagePicked);
    on<ProfileInfoUpdated>(_onProfileInfoUpdated);
  }

  Future<void> _onProfileInfoSuscriptionRequested(
    ProfileInfoSuscriptionRequested event,
    Emitter<ProfileScreenState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    await emit.onEach<UserEntity?>(
      getProfileInfo(),
      onData: (user) {
        if (user != null) {
          emit(state.copyWith(user: user, status: Status.success));
        } else {
          emit(state.copyWith(status: Status.failure));
        }
      },
    );
  }

  Future<void> _onNameChanged(
    NameChanged event,
    Emitter<ProfileScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        user: state.user!..updateName(event.name),
        isSaveButtonEnabled: true,
      ),
    );
  }

  Future<void> _onPhoneChanged(
    PhoneChanged event,
    Emitter<ProfileScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        user: state.user!..updatePhoneNumber(event.phone),
        isSaveButtonEnabled: true,
      ),
    );
  }

  Future<void> _onImagePicked(
    ImagePicked event,
    Emitter<ProfileScreenState> emit,
  ) async {
    final pickedImage = await pickUserImage();
    pickedImage.fold(
      () => null,
      (image) => {
        emit(
          state.copyWith(
            user: state.user!..updateImagePath(image.path),
            status: Status.success,
            isSaveButtonEnabled: true,
          ),
        ),
      },
    );
  }

  Future<void> _onProfileInfoUpdated(
    ProfileInfoUpdated event,
    Emitter<ProfileScreenState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormStatus.saving));
    await updateUserInfo(state.user!);
    emit(
      state.copyWith(
        isSaveButtonEnabled: false,
        formStatus: FormStatus.saved,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(formStatus: FormStatus.done));
  }
}

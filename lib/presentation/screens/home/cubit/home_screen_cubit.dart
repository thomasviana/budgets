import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/account/application.dart';
import '../../../../core/account/domain.dart';

part 'home_screen_state.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenState> {
  GetProfileInfo getProfileInfo;

  HomeScreenCubit(
    this.getProfileInfo,
  ) : super(HomeScreenState.initial());

  Future<void> init() async {
    // emit(state.copyWith(isLoading: true));
    // final displayName = await getProfileInfo();
    // displayName.fold(
    //   () => null,
    //   (user) => emit(state.copyWith(
    //     userName: user.name,
    //     isLoading: false,
    //   )),
    // );
  }
}

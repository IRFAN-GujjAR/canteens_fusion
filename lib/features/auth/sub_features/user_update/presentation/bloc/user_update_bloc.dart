import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/repositories/user_update_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/display_name_and_photo_url/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/phone_number/usecase.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/photo_url/params.dart';
import 'package:canteens_fusion/features/auth/sub_features/user_update/domain/usecases/photo_url/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_update_event.dart';
part 'user_update_state.dart';

final class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  late UserUpdatePhoneNumberUseCase _numberUseCase;
  late UserUpdateDisplayNameUseCase _displayNameUseCase;
  late UserUpdatePhotoUrlUseCase _photoUrlUseCase;
  late UserUpdateDisplayNameAndPhotoUrlUseCase _displayNameAndPhotoUrlUseCase;

  UserUpdateBloc({required UserUpdateRepo userUpdateRepo})
      : super(UserUpdateInitialState()) {
    _numberUseCase = UserUpdatePhoneNumberUseCase(userUpdateRepo);
    _displayNameUseCase = UserUpdateDisplayNameUseCase(userUpdateRepo);
    _photoUrlUseCase = UserUpdatePhotoUrlUseCase(userUpdateRepo);
    _displayNameAndPhotoUrlUseCase =
        UserUpdateDisplayNameAndPhotoUrlUseCase(userUpdateRepo);

    on<UpdatePhoneNumberUserUpdateEvent>((event, emit) async {
      await _onUpdatePhoneNumber(event, emit);
    });
    on<UpdateDisplayNameUserUpdateEvent>((event, emit) async {
      await _onUpdateDisplayName(event, emit);
    });
    on<UpdatePhotoUrlUserUpdateEvent>((event, emit) async {
      await _onUpdaePhotoUrl(event, emit);
    });
    on<UpdateDisplayNameAndPhotoUrlUserUpdateEvent>((event, emit) async {
      await _onUpdateDisplayNameAndPhotoUrl(event, emit);
    });
  }

  Future<void> _onUpdatePhoneNumber(UpdatePhoneNumberUserUpdateEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(UpdatingPhoneNumberUserUpdateState());
    try {
      await _numberUseCase.call(event.params);
      emit(UpdatedDisplayNameUserUpdateState());
    } catch (error) {
      printDebugMesg(
          dartFileName: 'UserUpdateBloc - UpdatePhoneNumber',
          msg: error.toString());
      emit(UpdateDisplayNameErrorUserUpdateState(errorMsg: error.toString()));
    }
  }

  Future<void> _onUpdateDisplayName(UpdateDisplayNameUserUpdateEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(UpdatingDisplayNameUserUpdateState());
    try {
      await _displayNameUseCase.call(event.params);
      emit(UpdatedDisplayNameUserUpdateState());
    } catch (error) {
      printDebugMesg(
          dartFileName: 'UserUpdateBloc - UpdateDisplayName',
          msg: error.toString());
      emit(UpdateDisplayNameErrorUserUpdateState(errorMsg: error.toString()));
    }
  }

  Future<void> _onUpdaePhotoUrl(UpdatePhotoUrlUserUpdateEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(UpdatingPhotoUrlUserUpdateState());
    try {
      await _photoUrlUseCase.call(event.params);
      emit(UpdatedPhotoUrlUserUpdateState());
    } catch (error) {
      printDebugMesg(
          dartFileName: 'UserUpdateBloc - UpdatePhotoUrl',
          msg: error.toString());
      emit(UpdatePhotoUrlErrorUserUpdateState(errorMsg: error.toString()));
    }
  }

  Future<void> _onUpdateDisplayNameAndPhotoUrl(
      UpdateDisplayNameAndPhotoUrlUserUpdateEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(UpdatingDisplayNameAndPhotoUrlUserUpdateState());
    try {
      await _displayNameAndPhotoUrlUseCase.call(event.params);
      emit(UpdatedDisplayNameAndPhotoUrlUserUpdateState());
    } catch (error) {
      printDebugMesg(
          dartFileName: 'UserUpdateBloc - UpdateDisplayNameAndPhotoUrl',
          msg: error.toString());
      emit(UpdateDisplayNameAndPhotoUrlErrorlUserUpdateState(
          errorMsg: error.toString()));
    }
  }
}

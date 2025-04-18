part of 'user_update_bloc.dart';

sealed class UserUpdateState extends Equatable {
  const UserUpdateState();

  @override
  List<Object?> get props => [];
}

final class UserUpdateInitialState extends UserUpdateState {}

final class UpdatingPhoneNumberUserUpdateState extends UserUpdateState {}

final class UpdatedPhoneNumberUserUpdateState extends UserUpdateState {}

final class UpdatePhoneNumberErrorUserUpdateState extends UserUpdateState {
  final String errorMsg;

  const UpdatePhoneNumberErrorUserUpdateState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class UpdatingDisplayNameUserUpdateState extends UserUpdateState {}

final class UpdatedDisplayNameUserUpdateState extends UserUpdateState {}

final class UpdateDisplayNameErrorUserUpdateState extends UserUpdateState {
  final String errorMsg;

  const UpdateDisplayNameErrorUserUpdateState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class UpdatingPhotoUrlUserUpdateState extends UserUpdateState {}

final class UpdatedPhotoUrlUserUpdateState extends UserUpdateState {}

final class UpdatePhotoUrlErrorUserUpdateState extends UserUpdateState {
  final String errorMsg;

  const UpdatePhotoUrlErrorUserUpdateState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class UpdatingDisplayNameAndPhotoUrlUserUpdateState
    extends UserUpdateState {}

final class UpdatedDisplayNameAndPhotoUrlUserUpdateState
    extends UserUpdateState {}

final class UpdateDisplayNameAndPhotoUrlErrorlUserUpdateState
    extends UserUpdateState {
  final String errorMsg;

  const UpdateDisplayNameAndPhotoUrlErrorlUserUpdateState(
      {required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

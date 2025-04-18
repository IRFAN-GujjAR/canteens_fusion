part of 'user_update_bloc.dart';

sealed class UserUpdateEvent extends Equatable {}

final class UpdatePhoneNumberUserUpdateEvent extends UserUpdateEvent {
  final UserUpdatePhoneNumberParams params;

  UpdatePhoneNumberUserUpdateEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

final class UpdateDisplayNameUserUpdateEvent extends UserUpdateEvent {
  final UserUpdateDisplayNameParams params;
  UpdateDisplayNameUserUpdateEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

final class UpdatePhotoUrlUserUpdateEvent extends UserUpdateEvent {
  final UserUpdatePhotoParams params;

  UpdatePhotoUrlUserUpdateEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

final class UpdateDisplayNameAndPhotoUrlUserUpdateEvent
    extends UserUpdateEvent {
  final UserUpdateDisplayNameAndPhotoParams params;

  UpdateDisplayNameAndPhotoUrlUserUpdateEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

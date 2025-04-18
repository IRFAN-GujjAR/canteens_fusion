import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CompleteProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CompleteProfileInitialState extends CompleteProfileState {}

final class CompleteProfileLoadingState extends CompleteProfileState {}

final class CompleteProfileLoadedState extends CompleteProfileState {
  final UserEntity user;

  CompleteProfileLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

final class CompleteProfileErrorState extends CompleteProfileState {
  final String errorMsg;

  CompleteProfileErrorState(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

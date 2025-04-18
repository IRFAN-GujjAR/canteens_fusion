import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class LocalDataEntity extends Equatable {
  final bool showUserTypeSelectionPage;
  final UserType userType;
  final UserEntity? user;

  const LocalDataEntity(
      {required this.showUserTypeSelectionPage,
      required this.userType,
      this.user});

  @override
  List<Object?> get props => [showUserTypeSelectionPage, userType, user];
}

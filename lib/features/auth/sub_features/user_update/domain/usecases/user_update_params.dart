import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:equatable/equatable.dart';

abstract class UserUpdateParams extends Equatable {
  final bool updateFirebaseAuth;
  final bool updateFireStore;
  final UserType userType;

  const UserUpdateParams(
      {this.updateFirebaseAuth = true,
      this.updateFireStore = true,
      required this.userType});

  @override
  List<Object?> get props => [updateFirebaseAuth, userType];
}

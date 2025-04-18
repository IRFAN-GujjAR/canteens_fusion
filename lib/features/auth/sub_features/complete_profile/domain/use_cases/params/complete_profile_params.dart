import 'package:canteens_fusion/core/constants/user_type_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompleteProfileParams extends Equatable {
  final String name;
  final XFile? profileImage;
  final UserType userType;

  const CompleteProfileParams(
      {required this.name, required this.profileImage, required this.userType});

  @override
  List<Object?> get props => [name, profileImage, userType];
}

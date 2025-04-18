import 'package:equatable/equatable.dart';

import '../../domain/use_cases/params/complete_profile_params.dart';

final class CompleteProfileEvent extends Equatable {
  final CompleteProfileParams params;

  const CompleteProfileEvent(this.params);

  @override
  List<Object?> get props => [params];
}

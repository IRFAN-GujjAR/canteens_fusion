import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  final String email;

  const ForgotPasswordEntity({required this.email});

  @override
  List<Object?> get props => [email];
}

import 'package:equatable/equatable.dart';

final class ForgotPasswordEvent extends Equatable {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

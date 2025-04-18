part of 'canteen_details_bloc.dart';

sealed class CanteenDetailsState extends Equatable {}

final class CanteenDetailsStateInitial extends CanteenDetailsState {
  @override
  List<Object?> get props => [];
}

final class CanteenDetailsStateFetching extends CanteenDetailsState {
  @override
  List<Object?> get props => [];
}

final class CanteenDetailsStateLoaded extends CanteenDetailsState {
  final CanteenDetailsEntity canteenDetails;

  CanteenDetailsStateLoaded(this.canteenDetails);

  @override
  List<Object?> get props => [canteenDetails];
}

final class CanteenDetailsStateError extends CanteenDetailsState {
  final String errorMsg;

  CanteenDetailsStateError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

final class CanteenDetailsStateNoCanteenFound extends CanteenDetailsState {
  @override
  List<Object?> get props => [];
}

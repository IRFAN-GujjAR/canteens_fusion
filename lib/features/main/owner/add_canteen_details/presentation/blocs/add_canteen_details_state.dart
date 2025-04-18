part of 'add_canteen_details_bloc.dart';

sealed class AddCanteenDetailsState extends Equatable {}

final class AddCanteenDetailsStateInitial extends AddCanteenDetailsState {
  @override
  List<Object?> get props => [];
}

final class AddCanteenDetailsStateAdding extends AddCanteenDetailsState {
  @override
  List<Object?> get props => [];
}

final class AddCanteenDetailsStateAdded extends AddCanteenDetailsState {
  final CanteenDetailsEntity canteenDetails;

  AddCanteenDetailsStateAdded(this.canteenDetails);

  @override
  List<Object?> get props => [canteenDetails];
}

final class AddCanteenDetailsStateError extends AddCanteenDetailsState {
  final String errorMsg;

  AddCanteenDetailsStateError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

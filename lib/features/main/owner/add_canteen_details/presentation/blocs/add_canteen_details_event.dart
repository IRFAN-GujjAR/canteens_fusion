part of 'add_canteen_details_bloc.dart';

sealed class AddCanteenDetailsEvent extends Equatable {}

final class AddCanteenDetailsEventAdd extends AddCanteenDetailsEvent {
  final AddCanteenDetailsParams params;

  AddCanteenDetailsEventAdd(this.params);

  @override
  List<Object?> get props => [params];
}

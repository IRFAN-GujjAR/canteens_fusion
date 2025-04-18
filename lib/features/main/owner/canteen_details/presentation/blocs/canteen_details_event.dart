part of 'canteen_details_bloc.dart';

sealed class CanteenDetailsEvent extends Equatable {}

final class CanteenDetailsEventFetch extends CanteenDetailsEvent {
  final String uid;

  CanteenDetailsEventFetch(this.uid);

  @override
  List<Object?> get props => [];
}

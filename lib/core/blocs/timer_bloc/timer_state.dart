part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

final class TimerInitial extends TimerState {}

final class TimerRunningState extends TimerState {
  final int secondsRemaining;

  const TimerRunningState({required this.secondsRemaining});
  @override
  List<Object> get props => [secondsRemaining];
}

final class TimerStoppedState extends TimerState {}

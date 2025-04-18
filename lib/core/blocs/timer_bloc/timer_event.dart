part of 'timer_bloc.dart';

sealed class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

final class StartTimerEvent extends TimerEvent {}

final class TimerEventUpdate extends TimerEvent {
  final int secondsRemaining;

  const TimerEventUpdate({required this.secondsRemaining});

  @override
  List<Object> get props => [secondsRemaining];
}

final class TimerStopEvent extends TimerEvent {}

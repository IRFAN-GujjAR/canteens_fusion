import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'timer_event.dart';
part 'timer_state.dart';

final class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  final int _seconds;

  TimerBloc({required int seconds})
      : _seconds = seconds,
        super(TimerInitial()) {
    on<StartTimerEvent>((event, emit) async {
      if (_timer != null) {
        _timer?.cancel();
      }
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick < _seconds) {
          add(TimerEventUpdate(secondsRemaining: _seconds - timer.tick));
        } else {
          add(TimerStopEvent());
        }
      });
    });
    on<TimerEventUpdate>((event, emit) {
      emit(TimerRunningState(secondsRemaining: event.secondsRemaining));
    });
    on<TimerStopEvent>((event, emit) async {
      _timer?.cancel();
      emit(TimerStoppedState());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

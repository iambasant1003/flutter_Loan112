import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loan112TimerCubit extends Cubit<int> {
  Loan112TimerCubit() : super(60); // initial value = 60 seconds

  Timer? _timer;

  void startTimer() {
    _timer?.cancel(); // cancel if already running
    emit(60); // reset to 60

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(60);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

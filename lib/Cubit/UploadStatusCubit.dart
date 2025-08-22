import 'package:flutter_bloc/flutter_bloc.dart';

class UploadStatusCubit extends Cubit<bool> {
  UploadStatusCubit() : super(false); // initially hidden

  void showSuccess() => emit(true);
  void hideSuccess() => emit(false);
  void toggle() => emit(!state);
}

import 'package:flutter_bloc/flutter_bloc.dart';

class JourneyCubit extends Cubit<Map<String, dynamic>> {
  JourneyCubit() : super({});


  void updateJourneyTabs(Map<String, dynamic> newTabs) {
    emit(newTabs);
  }


  void clear() {
    emit({});
  }
}

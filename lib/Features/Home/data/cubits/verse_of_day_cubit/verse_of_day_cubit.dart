import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/Home/data/cubits/verse_of_day_cubit/verse_of_day_states.dart';
import 'package:versea/Features/Home/data/cubits/verse_of_day_cubit/verse_of_the_day_functions.dart';

class VerseOfDayCubit extends Cubit<VerseOfDayStates> {
  VerseOfDayCubit() : super(VerseOfDayInitial());

  Future<Map<String, dynamic>> verseOfTheDay() async {
    emit(VerseOfDayLoading());
    try {
      final verseData = await getRef();
      emit(VerseOfDaySuccess(data: verseData));
      return verseData;
    } catch (e) {
      emit(VerseOfDayFailure(message: e.toString()));
    }
    throw Exception('Failed');
  }
}

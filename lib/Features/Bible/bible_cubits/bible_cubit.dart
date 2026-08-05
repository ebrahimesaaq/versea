import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/Bible/bible_cubits/bible_states.dart';

class BibleCubit extends Cubit<BibleStates> {
  BibleCubit() : super(BibleInitial());

  Future<void> changeTestament(bool isOldTestament) async {
    if (isOldTestament) {
      emit(BibleOldTest());
    } else {
      emit(BibleNewTest());
    }
  }
}

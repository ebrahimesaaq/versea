import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/Home/data/cubits/continue_reading_cubit/continue_reading_states.dart';

class ContinueReadingCubit extends Cubit<ContinueReadingStates> {
  ContinueReadingCubit() : super(ContinueReadingInitial());
}

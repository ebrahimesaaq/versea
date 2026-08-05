import 'package:versea/Features/Home/data/cubits/continue_reading_cubit/last_reading_model.dart';

class ContinueReadingStates {}

class ContinueReadingInitial extends ContinueReadingStates {}

class ContinueReadingSuccess extends ContinueReadingStates {
  final LastReadingModel? newTestData;
  final LastReadingModel? oldTestData;

  ContinueReadingSuccess({this.newTestData, this.oldTestData});
}

class ContinueReadingIsEmpty extends ContinueReadingStates {}

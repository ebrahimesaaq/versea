class VerseOfDayStates {}

class VerseOfDayInitial extends VerseOfDayStates {}

class VerseOfDayLoading extends VerseOfDayStates {}

class VerseOfDaySuccess extends VerseOfDayStates {
  final Map<String, dynamic> data;
  VerseOfDaySuccess({required this.data});
}

class VerseOfDayFailure extends VerseOfDayStates {
  final String message;
  VerseOfDayFailure({required this.message});
}

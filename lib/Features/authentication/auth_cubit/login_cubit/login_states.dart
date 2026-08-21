class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class EmailSentLoadingState extends LoginStates {}

class EmailSentSuccessState extends LoginStates {}

class EmailSentFailureState extends LoginStates {
  final String errMessage;
  EmailSentFailureState({required this.errMessage});
}

class LoginFailureState extends LoginStates {
  final String errMessage;
  LoginFailureState({required this.errMessage});
}

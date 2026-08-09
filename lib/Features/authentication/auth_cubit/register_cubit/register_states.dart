import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class RegisterStates {}

@immutable
class RegisterInitialState extends RegisterStates {}

@immutable
class RegisterLoadingState extends RegisterStates {}

@immutable
class RegisterSuccessState extends RegisterStates {
  final UserCredential userCredential;
  RegisterSuccessState({required this.userCredential});
}

@immutable
class RegisterFailureState extends RegisterStates {
  final String errorMessage;
  RegisterFailureState({required this.errorMessage});
}

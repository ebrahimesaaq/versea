import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/authentication/auth_cubit/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(RegisterLoadingState());
    await auth(email, password, fullName, emit);
  }
}

Future<void> auth(
  String email,
  String password,
  String fullName,
  Function(RegisterStates state) emit,
) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await saveUserDataInFirebaseFireStore(fullName);
    emit(RegisterSuccessState(userCredential: credential));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      emit(RegisterFailureState(errorMessage: 'Weak Password'));
    } else if (e.code == 'email-already-in-use') {
      emit(RegisterFailureState(errorMessage: 'Email already in use'));
    } else {
      emit(RegisterFailureState(errorMessage: e.code));
    }
  } catch (e) {
    emit(RegisterFailureState(errorMessage: '$e'));
  }
}

Future<void> saveUserDataInFirebaseFireStore(String fullName) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    await FirebaseFirestore.instance.collection('user_data').doc(user.uid).set({
      'full_name': fullName,
    });
  } else {
    throw Exception('No authenticated user found');
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/authentication/auth_cubit/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    await auth(email, password, emit);
  }
}

Future<void> auth(
  String email,
  String password,
  Function(RegisterStates state) emit,
) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:versea/Features/authentication/auth_cubit/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(LoginLoadingState());
    try {
      await firebaseAuthCode(email, password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailureState(errMessage: e.code));
    } catch (e) {
      emit(LoginFailureState(errMessage: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());
    try {
      await authWithGoogle();
      updateUserNameInFirebase();
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(errMessage: e.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(EmailSentSuccessState());
    } catch (e) {
      emit(EmailSentFailureState(errMessage: e.toString()));
    }
  }
}

Future<void> firebaseAuthCode(String email, String password) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<UserCredential> authWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
      .authenticate();
  final GoogleSignInAuthentication? googleAuth = googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> updateUserNameInFirebase() async {
  final user = FirebaseAuth.instance.currentUser;
  final userName = await FirebaseFirestore.instance
      .collection('user_data')
      .doc(user?.uid)
      .get();
  final fullName = userName.data()?['full_name'];
  final hasData = userName.exists;
  final isHasUserName = (fullName != '' && fullName != null) ? true : false;
  final userDoc = FirebaseFirestore.instance
      .collection('user_data')
      .doc(user?.uid);

  if (!hasData) {
    await userDoc.set({'full_name': user?.displayName});
  } else if (!isHasUserName) {
    await userDoc.update({'full_name': user?.displayName});
  }
}

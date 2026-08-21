import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  final user = FirebaseAuth.instance.currentUser;
  String email = '';
  String uid = '';
  String name = '';
  void defineData() {
    name = user!.displayName!;
    email = user!.email!;
    uid = user!.uid;
  }
}

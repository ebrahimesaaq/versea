import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';

class WelcomeCategory extends StatelessWidget {
  const WelcomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String> getName() async {
      final fullName = await FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      String firstName = await fullName['full_name'];
      return firstName.split(' ').first;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
          future: getName(),
          builder: (context, snapshot) {
            return Row(
              children: [
                Text(
                  '${S.of(context).welcome} ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                snapshot.data == null
                    ? FirebaseAuth.instance.currentUser?.displayName == null
                          ? Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Text(
                              (FirebaseAuth.instance.currentUser!.displayName!)
                                  .split(' ')
                                  .first,

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                    : Text(
                        '${snapshot.data}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            );
          },
        ),

        Text(S.of(context).miniTagLine, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

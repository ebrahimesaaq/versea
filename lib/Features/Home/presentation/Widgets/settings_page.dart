import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/routes/app_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('انتبه'),
                      content: Text('هل تريد حقا تسجيل الخروج؟'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            GoRouter.of(
                              context,
                            ).pushReplacement(AppRouter.kLoginScreen);
                          },
                          icon: Text(
                            'نعم',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Text('لا'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Row(
                children: [
                  Icon(Icons.logout_outlined, color: Colors.red),
                  SizedBox(width: 12),
                  Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

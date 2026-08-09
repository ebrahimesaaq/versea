import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/authentication/presentation/widgets/form_sign_up_filed.dart';
import 'package:versea/Features/authentication/presentation/widgets/icon_app.dart';
import 'package:versea/utils/routes/app_router.dart';

class SignUpUI extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController fullnameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final VoidCallback authFunction;
  const SignUpUI({
    super.key,
    required this.emailController,
    required this.fullnameController,
    required this.passwordController,
    required this.confirmPassController,
    required this.authFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        IconApp(),
        SizedBox(height: 8),
        const Text(
          'انشاء حساب جديد',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Libertinus',
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                offset: Offset(3, 8),
                blurRadius: 5,
              ),
            ],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FormSignUpFiled(
            authFunction: authFunction,
            emailController: emailController,
            fullnameController: fullnameController,
            passwordController: passwordController,
            confirmPassController: confirmPassController,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('لديك حساب بالفعل؟', style: TextStyle(fontSize: 16)),

            TextButton(
              onPressed: () {
                GoRouter.of(context).pushReplacement(AppRouter.kLoginScreen);
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.black),
              ),
              child: Text("تسجيل الدخول"),
            ),
          ],
        ),
        // Expanded(flex: 2, child: Container()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_button.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_text_form_filed.dart';
import 'package:versea/Features/authentication/presentation/widgets/icon_app.dart';
import 'package:versea/Features/authentication/presentation/widgets/other_ways_to_sign_in.dart';
import 'package:versea/Features/authentication/presentation/widgets/separator.dart';
import 'package:versea/utils/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              IconApp(),
              SizedBox(height: 8),
              const Text(
                'مرحبا بك من جديد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Libertinus',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextFormFiled(
                      textInputType: TextInputType.emailAddress,
                      title: 'البريد الإلكتروني',
                      hintText: 'أدخل بريدك الإلكتروني',
                    ),
                    AuthTextFormFiled(
                      textInputType: TextInputType.visiblePassword,
                      title: 'كلمة المرور',
                      hintText: 'أدخل كلمة المرور',
                    ),

                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerRight,
                      ),
                      child: Text(
                        'نسيت كلمة المرور؟',

                        style: TextStyle(
                          fontFamily: 'Libertinus',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    AuthButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Libertinus',
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Separator(),
              SizedBox(height: 20),
              OtherWaysToSignIn(),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ليس لديك حساب؟', style: TextStyle(fontSize: 16)),

                  TextButton(
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.kSignUpScreen);
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: Text('انشاء حساب'),
                  ),
                ],
              ),
              // Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

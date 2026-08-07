import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_button.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_text_form_filed.dart';
import 'package:versea/Features/authentication/presentation/widgets/icon_app.dart';
import 'package:versea/utils/routes/app_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextFormFiled(
                      textInputType: TextInputType.emailAddress,
                      title: 'البريد الإلكتروني',
                      hintText: 'أدخل بريدك الإلكتروني',
                    ),
                    AuthTextFormFiled(
                      textInputType: TextInputType.emailAddress,
                      title: 'اسم المستخدم',
                      hintText: 'أدخل اسم المستخدم',
                    ),
                    AuthTextFormFiled(
                      textInputType: TextInputType.visiblePassword,
                      title: 'كلمة المرور',
                      hintText: 'أدخل كلمة المرور',
                    ),
                    AuthTextFormFiled(
                      textInputType: TextInputType.visiblePassword,
                      title: 'اعادة كلمة المرور',
                      hintText: 'اعد ادخال كلمة المرور',
                    ),

                    SizedBox(height: 12),
                    AuthButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'انشاء الحساب',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ألديك حساب بالفعل؟', style: TextStyle(fontSize: 16)),

                  TextButton(
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.kLoginScreen);
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
          ),
        ),
      ),
    );
  }
}

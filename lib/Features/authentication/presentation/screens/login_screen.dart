import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/authentication/auth_cubit/login_cubit/login_cubit.dart';
import 'package:versea/Features/authentication/auth_cubit/login_cubit/login_states.dart';
import 'package:versea/Features/authentication/presentation/widgets/icon_app.dart';
import 'package:versea/Features/authentication/presentation/widgets/log_in_ui.dart';
import 'package:versea/Features/authentication/presentation/widgets/other_ways_to_sign_in.dart';
import 'package:versea/Features/authentication/presentation/widgets/separator.dart';
import 'package:versea/utils/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
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
              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
                  }
                  if (state is LoginFailureState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                  }
                  if (state is EmailSentFailureState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                  }
                  if (state is EmailSentSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'تم ارسال رابط الي بريدك الالكتروني بنجاح',
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      LogInUi(
                        forgetPassword: () {
                          context.read<LoginCubit>().forgetPassword(
                            emailController.text,
                          );
                        },
                        emailController: emailController,
                        passController: passController,
                        loginCode: () {
                          if (state is! EmailSentLoadingState) {
                            context
                                .read<LoginCubit>()
                                .loginWithEmailAndPassword(
                                  emailController.text,
                                  passController.text,
                                );
                          }
                        },
                      ),
                      if (state is LoginLoadingState ||
                          state is EmailSentLoadingState)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  );
                },
              ),

              SizedBox(height: 50),
              Separator(),
              SizedBox(height: 20),
              OtherWaysToSignIn(
                googleSignIn: () {
                  print('Google button pressed');
                  context.read<LoginCubit>().loginWithGoogle();
                },
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

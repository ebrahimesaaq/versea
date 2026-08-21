import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/authentication/auth_cubit/register_cubit/register_cubit.dart';
import 'package:versea/Features/authentication/auth_cubit/register_cubit/register_states.dart';
import 'package:versea/Features/authentication/presentation/widgets/sign_up_ui.dart';
import 'package:versea/utils/routes/app_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    fullnameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
              if (state is RegisterFailureState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
              if (state is RegisterSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
                );
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              }
            },
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SignUpUI(
                    emailController: emailController,
                    fullnameController: fullnameController,
                    passwordController: passwordController,
                    confirmPassController: confirmPassController,
                    authFunction: () {
                      context.read<RegisterCubit>().register(
                        fullName: fullnameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                  ),

                  if (state is RegisterLoadingState)
                    const Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

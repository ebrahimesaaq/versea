import 'package:flutter/material.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_button.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_text_form_filed.dart';

class FormSignUpFiled extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController fullnameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final void Function()? authFunction;
  const FormSignUpFiled({
    super.key,
    required this.emailController,
    required this.fullnameController,
    required this.passwordController,
    required this.confirmPassController,
    this.authFunction,
  });

  @override
  State<FormSignUpFiled> createState() => _FormSignUpFiledState();
}

class _FormSignUpFiledState extends State<FormSignUpFiled> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextFormFiled(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.emailController,
            textInputType: TextInputType.emailAddress,
            title: 'البريد الإلكتروني',
            hintText: 'أدخل بريدك الإلكتروني',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل البريد الإلكتروني';
              }

              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

              if (!emailRegex.hasMatch(value)) {
                return 'أدخل بريد إلكتروني صحيح';
              }

              return null;
            },
          ),
          AuthTextFormFiled(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'أدخل اسمك';
              }

              if (!RegExp(
                r'^[A-Za-z]+(?:\s+[A-Za-z]+)+$',
              ).hasMatch(value.trim())) {
                return 'أدخل اسمك الأول واسم العائلة';
              }

              return null;
            },
            controller: widget.fullnameController,
            textInputType: TextInputType.name,
            title: 'الاسم الكامل',
            hintText: 'أدخل اسمك الكامل',
          ),
          AuthTextFormFiled(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل كلمة المرور';
              }

              if (value.length < 8) {
                return 'كلمة المرور يجب أن تكون 8 خانات على الأقل';
              }

              if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                return 'يجب أن تحتوي على حرف';
              }

              if (!RegExp(r'\d').hasMatch(value)) {
                return 'يجب أن تحتوي على رقم';
              }

              if (!RegExp(
                r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]+=]',
              ).hasMatch(value)) {
                return 'يجب أن تحتوي على رمز';
              }

              return null;
            },
            obscureText: isPasswordVisible,
            controller: widget.passwordController,
            textInputType: TextInputType.visiblePassword,
            title: 'كلمة المرور',
            hintText: 'أدخل كلمة المرور',

            suffixIcon: IconButton(
              onPressed: () {
                isPasswordVisible = !isPasswordVisible;
                setState(() {});
              },
              icon: isPasswordVisible
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
            ),
          ),
          AuthTextFormFiled(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن ترك هذه الخانه فارغة';
              }

              if (value != widget.passwordController.text) {
                return 'كلمة المرور غير متطابقة';
              }

              return null;
            },
            obscureText: isConfirmPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                isConfirmPasswordVisible = !isConfirmPasswordVisible;
                setState(() {});
              },
              icon: isConfirmPasswordVisible
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
            ),
            controller: widget.confirmPassController,
            textInputType: TextInputType.visiblePassword,
            title: 'إعادة كلمة المرور',
            hintText: 'أعد ادخال كلمة المرور',
          ),

          SizedBox(height: 12),
          AuthButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.authFunction!();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'إنشاء الحساب',
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
    );
  }
}

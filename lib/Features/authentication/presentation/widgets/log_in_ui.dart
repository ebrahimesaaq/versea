import 'package:flutter/material.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_button.dart';
import 'package:versea/Features/authentication/presentation/widgets/auth_text_form_filed.dart';

class LogInUi extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  final VoidCallback loginCode;
  final VoidCallback forgetPassword;
  const LogInUi({
    super.key,
    required this.emailController,
    required this.passController,
    required this.loginCode,
    required this.forgetPassword,
  });

  @override
  State<LogInUi> createState() => _LogInUiState();
}

class _LogInUiState extends State<LogInUi> {
  bool isVisible = true;
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormFieldState> emailKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTextFormFiled(
              myKey: emailKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.emailController,
              textInputType: TextInputType.emailAddress,
              title: 'البريد الإلكتروني',
              hintText: 'أدخل بريدك الإلكتروني',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'من فضلك أدخل البريد الإلكتروني';
                }
                final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                if (!emailRegex.hasMatch(value)) {
                  return 'أدخل بريدًا إلكترونيًا صحيحًا';
                }
                return null;
              },
            ),
            AuthTextFormFiled(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.passController,
              obscureText: isVisible,
              suffixIcon: IconButton(
                onPressed: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                icon: !isVisible
                    ? Icon(Icons.visibility_off_outlined)
                    : Icon(Icons.visibility_outlined),
              ),
              textInputType: TextInputType.visiblePassword,
              title: 'كلمة المرور',
              hintText: 'أدخل كلمة المرور',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'من فضلك أدخل كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),

            TextButton(
              onPressed: () {
                if (emailKey.currentState!.validate()) {
                  widget.forgetPassword();
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerRight,
              ),
              child: Text(
                'نسيت كلمة المرور؟',

                style: TextStyle(fontFamily: 'Libertinus', color: Colors.black),
              ),
            ),
            SizedBox(height: 12),
            AuthButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.loginCode();
                }
              },
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
    );
  }
}

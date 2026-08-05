import 'package:flutter/material.dart';

class EndReadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  const EndReadingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text('انهاء القراءة'));
  }
}

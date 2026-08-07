import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
        SizedBox(width: 8),
        Text(
          'أو أكمل باستخدام',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Libertinus',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8),
        Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
      ],
    );
  }
}

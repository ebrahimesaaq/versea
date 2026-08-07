import 'package:flutter/material.dart';

class IconApp extends StatelessWidget {
  const IconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              offset: Offset(3, 5),
              blurRadius: 3,
            ),
          ],
          color: Colors.grey[100],
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset('assets/images/cross.png'),
      ),
    );
  }
}

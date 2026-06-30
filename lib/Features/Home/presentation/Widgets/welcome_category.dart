import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';

class WelcomeCategory extends StatelessWidget {
  const WelcomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${S.of(context).welcome} Abram',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(S.of(context).miniTagLine, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

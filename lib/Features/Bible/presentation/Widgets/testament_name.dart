import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';

class TestamentName extends StatelessWidget {
  final bool isOldTest;
  final Color? color;
  final void Function()? onTap;
  const TestamentName({
    super.key,
    required this.isOldTest,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color,
          ),
          height: 60,
          child: Center(
            child: Text(
              isOldTest
                  ? S.of(context).oldTestament
                  : S.of(context).newTestament,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

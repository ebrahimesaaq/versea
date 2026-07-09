import 'package:flutter/material.dart';
import 'package:versea/Features/Bible/presentation/Widgets/testament_name.dart';
import 'package:versea/utils/Core/app_colors.dart';

class TestamentChose extends StatelessWidget {
  final bool modeIsLight;
  final void Function()? onOldTap;
  final void Function()? onNewTap;

  final bool isNew;

  const TestamentChose({
    super.key,
    this.onOldTap,
    this.onNewTap,
    required this.isNew,
    required this.modeIsLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: modeIsLight
            ? Colors.brown[300]!.withValues(alpha: 0.5)
            : Colors.grey[900],
        borderRadius: BorderRadius.circular(100),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TestamentName(
            isOldTest: false,
            color: isNew
                ? modeIsLight
                      ? DarkAppColors.secondaryColor
                      : Colors.amber[700]
                : null,
            onTap: onNewTap,
          ),
          TestamentName(
            onTap: onOldTap,
            isOldTest: true,
            color: isNew
                ? null
                : modeIsLight
                ? DarkAppColors.secondaryColor
                : Colors.amber[700],
          ),
        ],
      ),
    );
  }
}

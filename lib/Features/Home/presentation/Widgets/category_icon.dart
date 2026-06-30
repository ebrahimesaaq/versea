import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/utils/Core/app_colors.dart';
import 'package:versea/utils/routes/app_router.dart';

class CategoryIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isYellow;
  const CategoryIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.isYellow,
  });

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => GoRouter.of(context).push(AppRouter.kTestament),
      child: Container(
        width: widthSize * 0.45,
        height: widthSize * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: (isDark ? DarkAppColors2.tertiaryColor : Colors.grey)
              .withValues(alpha: 0.5),

          // .withValues(alpha: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 40,
              backgroundColor: isYellow
                  ? DarkAppColors.secondaryColor
                  : DarkAppColors.tertiaryColor,
              child: Icon(
                icon,

                color: isYellow ? Colors.amber[200] : Colors.deepPurple[300],
                size: 55,
              ),
            ),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

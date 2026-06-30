import 'package:flutter/material.dart';
import 'package:versea/Features/Home/presentation/Widgets/category_icon.dart';
import 'package:versea/generated/l10n.dart';

class CategoriesCategory extends StatelessWidget {
  const CategoriesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).categories,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

        SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CategoryIcon(
                  icon: Icons.menu_book_rounded,
                  title: S.of(context).bible,
                  isYellow: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:versea/Features/Home/presentation/Widgets/buttons.dart';
import 'package:versea/Features/Home/presentation/Widgets/verse.dart';
import 'package:versea/utils/Core/assets.dart';

class VerseOfTheDayCategory extends StatelessWidget {
  const VerseOfTheDayCategory({super.key});

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18),
      width: double.infinity,
      height: height * 0.32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme ? Colors.grey[300] : Colors.cyanAccent,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(
                theme ? Assets.darkVOD : Assets.lightVOD,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Verse(),
              SizedBox(height: 17),
              Buttons(),
            ],
          ),
        ],
      ),
    );
  }
}

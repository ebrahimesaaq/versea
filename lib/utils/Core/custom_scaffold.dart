import 'package:flutter/material.dart';
import 'package:versea/utils/Core/assets.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  const CustomScaffold({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: ClipRRect(
              child: Image.asset(
                theme ? Assets.darkBG : Assets.lightBG,
                fit: BoxFit.fill,
              ),
            ),
          ),
          body ?? SizedBox(),
        ],
      ),
    );
  }
}

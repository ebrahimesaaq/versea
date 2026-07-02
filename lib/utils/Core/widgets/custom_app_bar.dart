import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 55),
      width: double.infinity,
      child: Row(
        children: [
          if (Navigator.canPop(context))
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          Spacer(),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: LightAppColors.neutralColor,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

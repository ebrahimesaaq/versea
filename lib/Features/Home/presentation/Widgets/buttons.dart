import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/app_colors.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(),
        Container(
          decoration: BoxDecoration(
            color: LightAppColors.primaryColor,

            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.share_outlined, size: 17, color: Colors.white),
              SizedBox(width: 7),
              Text(
                S.of(context).share,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: DarkAppColors.secondaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.bookmark_border_outlined,
                size: 17,
                color: LightAppColors.secondaryColor,
              ),
              SizedBox(width: 7),
              Text(
                S.of(context).save,
                style: TextStyle(
                  fontSize: 16,
                  color: LightAppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OtherWaysToSignIn extends StatelessWidget {
  final void Function()? googleSignIn;
  final void Function()? facebookSignIn;
  final void Function()? appleSignIn;
  const OtherWaysToSignIn({
    super.key,
    this.googleSignIn,
    this.facebookSignIn,
    this.appleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: MaterialButton(
            onPressed: googleSignIn,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),

            child: SvgPicture.asset(
              'assets/images/icons/google_logo.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Platform.isIOS ? SizedBox(width: 16) : SizedBox(),
        Platform.isIOS
            ? SizedBox(
                width: 50,
                height: 50,
                child: MaterialButton(
                  onPressed: appleSignIn,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),

                  child: SvgPicture.asset(
                    'assets/images/icons/apple_logo.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(width: 16),
        SizedBox(
          width: 50,
          height: 50,
          child: MaterialButton(
            onPressed: facebookSignIn,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),

            child: SvgPicture.asset(
              'assets/images/icons/facebook_logo.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}

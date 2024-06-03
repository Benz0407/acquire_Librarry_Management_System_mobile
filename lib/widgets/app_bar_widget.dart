import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:flutter/material.dart';

class AcquireTitle extends StatelessWidget {
  const AcquireTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/Logo.png',
          width: 50,
          height: 50,
        ),
        horizontalSpacing(15), 
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                      color: Color(0xFFCC0000),
                      fontSize: 30,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'CQUIRE',
                    style: TextStyle(
                      color: Color(0xFF3D3D3D),
                      fontSize: 30,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Library Management System',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'League Spartan',
                fontWeight: FontWeight.w400,
                height: 0.12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

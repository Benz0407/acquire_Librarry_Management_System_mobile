import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  final String headerText;
  const ScreenHeader({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero, 
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            transform: Matrix4.identity()..rotateZ(1.57),
            alignment: Alignment.center,
            child: Container(
              width: 40, 
              height: 10,
              color: const Color(0xFFCC0000),
              margin: EdgeInsets.zero, // Remove any default margin
              padding: EdgeInsets.zero, 
            ),
          ),
          
          Column(
            
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              
              Text(
                
                headerText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w900,
                  height: 1, // Adjusted to avoid overlapping
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

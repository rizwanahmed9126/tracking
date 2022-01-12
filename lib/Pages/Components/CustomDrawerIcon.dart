import 'package:flutter/material.dart';

class CustomDrawerIcon extends StatelessWidget {
  final Widget iconPadding;
  CustomDrawerIcon({
    this.iconPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300],
                offset: Offset(1,0.7),
                blurRadius: 6,
                spreadRadius: 0.5
            ),
          ]
      ),

      child: CircleAvatar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: iconPadding
      ),
    );
  }
}

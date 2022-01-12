import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor, iconColor;
  final double iconSize;
  final double fontSize;

  const TextWithIcon({
    this.icon,
    this.text,
    this.iconColor,
    this.textColor,
    this.iconSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon,size: iconSize,color: iconColor,),
            ),
          ),
          TextSpan(text: text,style: GoogleFonts.poppins(color: textColor,fontSize:fontSize )),
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  final Color colors;
  final double fontSize;
  final String title;
  CustomTitle({
    this.title,
    this.colors,
    this.fontSize,
});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text(title,style: GoogleFonts.poppins(fontSize: fontSize,color: colors),),
        ),
      ],
    );
  }
}

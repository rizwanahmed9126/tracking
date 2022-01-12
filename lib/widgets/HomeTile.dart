import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:i18n_extension/i18n_widget.dart';


class HomeTile extends StatelessWidget {
  final Function press;
  final String title;
  final String imagePath;
  final double height;
  final Color colors;

  HomeTile({
    this.press,
    this.title,
    this.imagePath,
    this.height,
    this.colors
  });

  //double abc=12.w;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(

        decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: Offset(0,3),
                  color: Color(0xffebf1f8),
              )
            ]
        ),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                  //  color: Colors.red,
                    height: height,
                    width: size.width,
                    child: Center(
                        child: Image.asset(imagePath,)
                    ),
                  ),


             // SizedBox(height: 5,),

              Container(
                height: size.height*0.03,
                  width: size.width,
                  //color: Colors.red,
                  child: Center(
                    child: AutoSizeText(
                      title,style: GoogleFonts.poppins(fontSize:13),
                      maxLines: 2,
                      minFontSize: 12,
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
                ],
              ),
            ),
          ],
        ),


      ),
    );
  }
}

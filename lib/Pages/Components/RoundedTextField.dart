import 'package:flutter/material.dart';


class RoundedTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChnaged;
  final TextEditingController controller;

  const RoundedTextField({
    this.hintText,
    this.onChnaged,
    this.controller
  });


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height*0.070,
      width: size.width*0.7,
      decoration: BoxDecoration(
          //border: Border.all(color: Color(0xff7EC049)),
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[200]
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.lightGreen,
        onChanged: onChnaged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
          // icon: Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Icon(Icons.person,color: Colors.lightGreen,),
          // ),


          border: InputBorder.none,
          fillColor: Colors.grey[200],

          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),

        ),
      ),
    );
  }
}
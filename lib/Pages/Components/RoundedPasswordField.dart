import 'package:flutter/material.dart';

class RoundedPasswordTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChnaged;
  final bool obscuretext;
  final Function press;
  final TextEditingController controller;

  const RoundedPasswordTextField({
    this.hintText,
    this.onChnaged,
    this.controller,
    this.obscuretext = false,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.070,
      width: size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.grey[200]),
      child: TextField(
        cursorColor: Colors.lightGreen,
        controller: controller,
        obscureText: obscuretext,
        onChanged: onChnaged,

        // validator: MultiValidator([
        //   RequiredValidator(errorText: 'Required *'),
        // ]),

        decoration: InputDecoration(
            border: InputBorder.none,

            // icon: Padding(
            //   padding: const EdgeInsets.only(left: 10),
            //   child: Icon(Icons.lock,color: Colors.lightGreen,),
            // ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),

            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8),
            //   borderSide: BorderSide(
            //     width: 0,
            //     style: BorderStyle.none,
            //   ),
            // ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: IconButton(
                icon: Icon(
                  obscuretext
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black,
                ),
                onPressed: press)),
      ),
    );
  }
}

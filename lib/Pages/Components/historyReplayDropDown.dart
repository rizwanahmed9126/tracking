

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';


class HistoryReplayDropDown{


  Widget dropDownAndroid(List data, String selectedValue, Function onChanged) {
    return DropdownButton(

      icon: Icon(FeatherIcons.arrowDownCircle,color: Color(0xff87a564),),
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 12.0,
      ),
      isExpanded: true,
      value: selectedValue,
      onChanged: (newValue) {
        onChanged(newValue);
        print(newValue);
      },
      items: [
        for (var i in data)
          DropdownMenuItem(
            value: i,
            child: Center(
              child: Text(i),
            ),
          )
      ],
    );
  }
}
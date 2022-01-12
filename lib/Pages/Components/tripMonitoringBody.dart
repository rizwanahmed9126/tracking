import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/tripMonitoringCard.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class TripMonitoringBody extends StatefulWidget {
  const TripMonitoringBody({Key key}) : super(key: key);

  @override
  _TripMonitoringBodyState createState() => _TripMonitoringBodyState();
}

class _TripMonitoringBodyState extends State<TripMonitoringBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          child: Container(
            height: 40.0,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(18.0)),
            child: TextFormField(
              cursorColor: Color(0xff5E8633),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  labelText: LocaleKeys.search_vrn.tr(),
                  labelStyle: GoogleFonts.poppins(
                      color: Color(0xff5E8633), fontSize: 12.0),
                  suffixIcon: Icon(
                    FeatherIcons.search,
                    color: Color(0xff5E8633),
                    size: 16.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                      BorderSide(width: 0, style: BorderStyle.none))),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TripMonitoringCard();
                }))
      ],
    );
  }
}
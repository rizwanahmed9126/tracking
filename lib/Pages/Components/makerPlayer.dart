import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/markerPlayerControl.dart';
import 'package:flutter_map_marker_animation_example/Entities/textSpeaker.dart';
import 'package:flutter_map_marker_animation_example/Pages/IconsUtils.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:toast/toast.dart';
import 'package:easy_localization/easy_localization.dart';

const kMarkerId = MarkerId('MarkerId1');

class MarkerPlayerButtons extends StatefulWidget {
  final controller;
  //final double runTimeValue;

  MarkerPlayerButtons({this.controller,});

  @override
  _MarkerPlayerButtonsState createState() => _MarkerPlayerButtonsState();
}

class _MarkerPlayerButtonsState extends State<MarkerPlayerButtons>
    with SingleTickerProviderStateMixin {
  bool playSelected = false;
  bool pauseSelected = false;
  bool resumeSelected = false;
  bool sliderSelected = false;
  TextSpeaker tts = TextSpeaker();
  int speedValue = 1;
  double value=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tts.setLanguageToEnglish();
    value=Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(bottom: 15.0),
        // width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.15,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26.withOpacity(0.65),
                blurRadius: 35.0,
                spreadRadius: 40.0,
                offset: Offset(15, 15))
          ],
          // color: Colors.black26,
        ),
        child: sliderSelected
            ? Container(
          height: 100.0,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: RangeSlider(
                  value: Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount, //25.0,
                  controller: widget.controller,
                  max: Provider.of<MarkerPlayerControl>(context, listen: false).carCoordinates.length.toDouble(),
                  min: 0,
                  onPressed: (val) {
                    value=val;
                    setState(() {
                       sliderSelected = false;
                       resumeSelected = false;
                    });
                  },
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resumeSelected = false;
                        playSelected = false;
                        pauseSelected = true;
                      });
                      Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount=0;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .markers2
                          .clear();
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .markers
                          .clear();
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .clearMakerList();

                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .i = 0;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .j = 0;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .k = 0;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .isPaused = false;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .firstTime = false;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .runMarker(kMarkerId, widget.controller, context);
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .pauseMarker();
                    },
                    child: pauseSelected
                        ? Container(
                            height: 90.0,
                            width: 90.0,
                            //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FeatherIcons.refreshCw,
                                    size: 30.0,
                                    color: Color(0xff5E8633),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    LocaleKeys.Reset.tr(),
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff5E8633),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.refreshCw,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              Text(
                                LocaleKeys.Reset.tr(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        playSelected = false;
                        pauseSelected = false;
                        resumeSelected = true;
                      });
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .markers2
                          .clear();
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .markers
                          .clear();
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .clearMakerList();
                      //Provider.of<MarkerPlayerControl>(context, listen: false).i = 0;
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .isPaused = false;
                      //Provider.of<MarkerPlayerControl>(context, listen: false).getParkedLocationPins();
                      Provider.of<MarkerPlayerControl>(context, listen: false)
                          .firstTime = true;
                      String check = await Provider.of<MarkerPlayerControl>(
                              context,
                              listen: false)
                          .runMarker(kMarkerId, widget.controller, context);
                      if (check != null) {
                        print(check);
                        //showInSnackBar("History Replay has been completed");
                        Toast.show('History Replay has been completed', context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.CENTER,
                            textColor: Color(0xff5E8633),
                          backgroundColor: Colors.white
                        );
                        await tts.speakInGirlVoice('history replay has been completed');
                      }
                    },
                    child: resumeSelected
                        ? PlayPause(
                            controller: widget.controller,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.playCircle,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              Text(
                                LocaleKeys.Play.tr(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pauseSelected = false;
                        resumeSelected = true;
                        playSelected = true;
                        sliderSelected = true;
                      });
                    },
                    child: playSelected
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                if (speedValue > 3)
                                  speedValue = 1;
                                else
                                  speedValue += 1;
                              });
                            },
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FeatherIcons.gitCommit,
                                      size: 30.0,
                                      color: Color(0xff5E8633),
                                    ),
                                    // Text(
                                    //   '${speedValue}x',
                                    //   style: GoogleFonts.poppins(
                                    //       color: Color(0xff5E8633),
                                    //       fontSize: 16.0,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      LocaleKeys.Start_point.tr(),
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff5E8633),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.gitCommit,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              Text(
                                LocaleKeys.Start_point.tr(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: new Text(value)));
  }
}

class RangeSlider extends StatefulWidget {
  final double min, max;
  var value;
  final Function onPressed;
  final controller;

  RangeSlider(
      {@required this.max,
      @required this.min,
      @required this.onPressed,
      @required this.controller,
        @required this.value
      });

  @override
  _RangeSliderState createState() => _RangeSliderState();
}

class _RangeSliderState extends State<RangeSlider> {

  double value=0;
  @override
  void initState() {
    super.initState();
    setState(() {
      value=widget.value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 8.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        height: 130.0,
        width: double.maxFinite,
        decoration: BoxDecoration(
            //color: Colors.red,
            borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color(0xff5E8633),
                  inactiveTrackColor: Colors.green[100],
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 8.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  thumbColor: Color(0xff5E8633),
                  overlayColor: Colors.greenAccent[50],
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: Colors.green[700],
                  inactiveTickMarkColor: Colors.green[100],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Color(0xff5E8633),
                  valueIndicatorTextStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  min: widget.min,
                  max: widget.max,
                  value: value,
                  label: '${value.round()}',
                  divisions: (widget.max - widget.min).round(),
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                  onChangeEnd: (newValue) async {
                    Provider.of<MarkerPlayerControl>(context, listen: false).changeMarker(kMarkerId, value.round(), widget.controller,context);
                    Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount=value;
                  },
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child:
                    TextButton(
                      onPressed: () {

                        widget.onPressed(value);
                           Provider.of<MarkerPlayerControl>(context, listen: false).startPointCount=value;

                      //Navigator.pop(context);
                      },
                      child:
                          Text(
                            LocaleKeys.Ok.tr(),
                            style: GoogleFonts.poppins(
                                color: Color(0xff5E8633), fontWeight: FontWeight.bold),
                          ),

                    ),

              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayPause extends StatefulWidget {
  final controller;

  PlayPause({
    this.controller,
  });

  @override
  _PlayPauseState createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return _isSelected
        ? GestureDetector(
            onTap: () {
              setState(() {
                _isSelected = !_isSelected;
              });

              Provider.of<MarkerPlayerControl>(context, listen: false)
                  .resumeMarker(kMarkerId, widget.controller, context);
            },
            child: Container(
              height: 90.0,
              width: 90.0,
              //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.playCircle,
                      size: 30.0,
                      color: Color(0xff5E8633),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      LocaleKeys.Play.tr(),
                      style: GoogleFonts.poppins(
                          color: Color(0xff5E8633),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                _isSelected = !_isSelected;
              });

              Provider.of<MarkerPlayerControl>(context, listen: false)
                  .pauseMarker();
            },
            child: Container(
              height: 90.0,
              width: 90.0,
              //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.pauseCircle,
                      size: 30.0,
                      color: Color(0xff5E8633),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      LocaleKeys.Pause.tr(),
                      style: GoogleFonts.poppins(
                          color: Color(0xff5E8633),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryDetails.dart';
import 'package:flutter_map_marker_animation_example/Entities/HistoryReports.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/alertBox.dart';
import 'package:flutter_map_marker_animation_example/Pages/SelectSpeedVehicle.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SpeedReport extends StatefulWidget {
  List<CarLocationDetails> data = [];
  List<HistoryReport> data1 = [];
  String streak;
  String vehicleNumber;

  SpeedReport({
    this.data,
    this.streak,
    this.vehicleNumber,
    this.data1
  });

  @override
  _SpeedReportState createState() => new _SpeedReportState();
}

class _SpeedReportState extends State<SpeedReport> {
  Timer _timer;
  double _value = 0.0;
  List<double> _value1 = [];
  int i = 0;

  List<ChartSampleData > dates = [];
  double avgSum = 0.0;
  double parkedSum = 0.0;
  double idleSum = 0.0;
  var parked;
  var idle;

  var satelite;
  var angle;
  var ignition;
  var mileage1;
  var fuel;
  var brake;
  var deviceStatus;
  var deviceAlarm;
  var referenceLocation;

  //var vehicleNumber;

  int onlyOnce = 1;
  List<ChartSampleData> dates1 = [];

  @override
  void initState() {
    super.initState();

    widget.data1.forEach((element) {
      dates1.add(ChartSampleData(x: DateTime.parse(element.time), yValue: element.distanceTravel),);
      print('thi si the api data--------------${element.mileage}');
    });

    mileage1 = widget.data[widget.data.length - 1].mileage;
    referenceLocation = widget.data[widget.data.length - 1].referenceLocation;

    int check = widget.data.indexWhere((element) => element.vehicleStatus=="Moving");
    //if(check>0){
    widget.data.forEach((element) {
      setState(() {
        int mileage = element.mileage.toInt();

        // dates.add(MyRow(DateTime.parse('${element.receiveDateTime}'), mileage));
        // print('${element.receiveDateTime}');
        //
        // String date = element.receiveDateTime;
        // List parts = date.split("T");
        // print('parsed time${parts[0]}');
        //
        // if(element.vehicleStatus=='Moving')
        //   dates1.add(ChartSampleData(x: DateTime.parse(element.receiveDateTime), yValue: element.speed),);


        print('length of the date1--${dates1.length}');
        _value1.add(element.speed);
        if (onlyOnce == 1) {
          satelite = element.visibleSatelites;
          angle = element.angle;
          if(element.ignitionStatus==true)
            ignition='ON';
          else
            ignition='OFF';
          //ignition = element.ignitionStatus;
          fuel = element.fuelStatus;
          if(element.harshBreak=="True")
            brake="Yes";
          else
            brake="No";


          //brake = element.harshBreak;
          deviceStatus = element.deviceStatus;
          deviceAlarm = element.deviceAlarm;
          //mileage1=element.mileage;
          onlyOnce = 0;
        }

      });
    });

    for (int i = 0; i < _value1.length; i++) {
      avgSum += _value1[i];
    }
    avgSum = avgSum / _value1.length;

    print('avaergae value of speed---------------$avgSum');
    for (int i = 0; i < ParkedMarkers.time.length; i++) {
      parkedSum += ParkedMarkers.time[i];
    }
    for (int i = 0; i < ParkedMarkers.idleTime.length; i++) {
      idleSum += ParkedMarkers.idleTime[i];
    }
    parked = convertMinutesToHours(parkedSum.toInt());
    idle = convertMinutesToHours(idleSum.toInt());
    print('$parked this is the parked time-----------');
    print('$idle this is the idle time-----------');
    print('maximum value in the list-----------${_value1.reduce(max)}');
    print('minimum value i the list-------${_value1.reduce(min)}');
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_timer) {
      setState(() {
        if (i < _value1.length) {
          _value = _value1[i];
          print('data from timer-------------${_value1[i]}');
        } else {
          print('i get into this function');
          _timer.cancel();
        }
      });

      i = i + 1;
    });
  }

  TooltipBehavior _tooltipBehavior;

  @override
  void dispose() {
    _timer.cancel();
    _tooltipBehavior =  TooltipBehavior(enable: true);
    super.dispose();
  }

  Widget _getRadialGauge() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.78,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
          GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10),
          GaugeRange(
              startValue: 50,
              endValue: 100,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10),
          GaugeRange(
              startValue: 100,
              endValue: 150,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10)
        ], pointers: <GaugePointer>[
          NeedlePointer(
              value: _value??0,
              needleLength: 0.85,
              enableAnimation: true,
              animationType: AnimationType.ease,
              needleStartWidth: 1.5,
              needleEndWidth: 4,
              needleColor: Colors.red,
              knobStyle:
              KnobStyle(knobRadius: 0.09, sizeUnit: GaugeSizeUnit.factor))
        ], annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              widget: Container(
                  child: Center(
                    child: Text('${_value??0} KMH',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )),
              angle: 90,
              positionFactor: 0.5)
        ])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                    child: Container(
                      child: Text(
                        "${LocaleKeys.your_are_on_a.tr()} \n ${widget.streak} ${LocaleKeys.streak.tr()}",
                        style: GoogleFonts.poppins(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: _getRadialGauge()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      minMaxSpeedWidget(context, LocaleKeys.min_speed.tr(), Colors.green, _value!=null?_value1.reduce(min): 0.0) ,
                      minMaxSpeedWidget(context,LocaleKeys.average_speed.tr(), Colors.orange, double.parse(avgSum.toStringAsFixed(2))),
                      minMaxSpeedWidget(context, LocaleKeys.max_speed.tr(), Colors.red, _value1.reduce(max)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      child: Text(
                        LocaleKeys.mileage.tr(),
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ),
                graph(context, _tooltipBehavior, dates1),
                // Container(
                //   height: 200,
                //   width: MediaQuery.of(context).size.width,
                //   child: ChartCustomYAxis(
                //     dates: dates,
                //   ),
                // ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    //color: Colors.grey[200],
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(22)),
                  child: TextButton(
                    onPressed: () async {
                      bottomSheet(
                          context,
                          parked,
                          idle,
                          satelite,
                          angle,
                          ignition,
                          mileage1,
                          fuel,
                          brake,
                          deviceStatus,
                          deviceAlarm,
                          referenceLocation,
                          widget.vehicleNumber);
                    },
                    child: Text(
                      LocaleKeys.see_details.tr(),
                      style: TextStyle(color: Colors.white
                        //Color(0xff36b14d)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget timeWidget(String name) {
  return Container(
    height: 50,
    width: 120,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey[200], spreadRadius: 10, blurRadius: 15)
        ]),
    child: Center(child: Text(name)),
  );
}

Widget minMaxSpeedWidget(BuildContext context,String name, Color colors, double speed) {
  return Container(
      height: MediaQuery.of(context).size.height*0.26,
      width: MediaQuery.of(context).size.width*0.295,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              spreadRadius: 15,
              blurRadius: 20,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Text(name)),
            Expanded(
              flex: 4,
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 8.0,
                animation: true,
                percent: speed / 100,
                //center:
                backgroundColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: colors,
              ),
            ),
            Expanded(
              child: Text(
                '$speed km/h',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ));
}

// class MyRow {
//   final DateTime timeStamp;
//   final int cost;
//
//   MyRow(this.timeStamp, this.cost);
// }

Widget bottomSheet(
    context,
    //String carNumber,String address,String box1Text,String box2Text,String box3Text,  String text1,String text2,String text3,String text4,
    String parkedSum,
    String idleSum,
    var satelite,
    var angle,
    var ignition,
    var mileage,
    var fuel,
    var brake,
    var deviceStatus,
    var deviceAlarm,
    var referenceLocation,
    var vehicleNumber) {
  Size size = MediaQuery.of(context).size;

  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        height: 5,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(22)),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 6,
                      child:
                      Container(
                        //height: 200,
                        //width: 200,
                          child: Image.asset('assets/images/ic_car.png',
                              height: size.height * 0.2, fit: BoxFit.fill)),
                    ),
                    Text(
                      '$vehicleNumber',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    Container(
                        child: Text(
                          '$referenceLocation',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),

                    // Text('total parked $parkedSum'),
                    //
                    // Text('total idle $idleSum'),

                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,

                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        //childAspectRatio: (0.3/ 0.24),

                        children: [
                          customTiles("assets/satellite.png", '$satelite','Satelite'),
                          customTiles('assets/angle.png', '$angle','Angle'),
                          customTiles('assets/ignition.png', '$ignition','Ignition'),
                          customTiles('assets/mileage.png', '$mileage','Mileage'),
                          customTiles('assets/fuel.png', '$fuel','Fuel'),
                          customTiles('assets/brake.png', '$brake','Harsh Brake'),
                          // customTiles(
                          //     'assets/deviceStatus.png', '$deviceStatus'),
                          customTiles('assets/deviceAlarm.png', '$deviceAlarm','Device Alarm'),
                          //
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        left: 5,
                        top: 15,
                      ),
                      child: showIdleParkedTime(
                          context, LocaleKeys.total_parked_time.tr(), '$parkedSum'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 5, top: 15, bottom: 20),
                      child: showIdleParkedTime(
                          context, LocaleKeys.total_idle_time.tr(), '$idleSum'),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Widget customTiles(String iconPath,var value,String name){
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[100],
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0,3)
          )
        ]
    ),
    child: Wrap(
      direction: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Center(
            child: Column(
              children: [
                ImageIcon(
                  AssetImage(iconPath),
                  size: 22,
                ),
                SizedBox(height: 1,),
                Text(value,style: TextStyle(fontSize: 11),),
                Text(name,style: TextStyle(fontSize: 11),)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget showIdleParkedTime(context, String name, String parkedTime) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[100],
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3))
        ]),
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(name), Text(parkedTime)],
      ),
    ),
  );
}




Widget graph(context, TooltipBehavior _tooltipBehavior, List<ChartSampleData> chartData){
  return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: SfCartesianChart(


          tooltipBehavior: _tooltipBehavior,
          backgroundColor: Colors.white,
          //Specifying date time interval type as hours
          primaryXAxis: DateTimeAxis(
            //majorGridLines: MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              intervalType: DateTimeIntervalType.hours),
          series: <ChartSeries<ChartSampleData, DateTime>>[
            LineSeries<ChartSampleData, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartSampleData sales, _) => sales.x,
                yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                name: 'Sales',
                enableTooltip: true

            )
          ]));
}



// ignore: must_be_immutable
class LineChartSample9 extends StatefulWidget {
  //final spots = List.generate(500, (i) => (i - 50) / 2).map((x) => FlSpot(x, sin(x))).toList();

  //LineChartSample9();

  @override
  State<LineChartSample9> createState() => _LineChartSample9State();
}

class _LineChartSample9State extends State<LineChartSample9> {
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: DateTime(2015, 1, 1, 0), yValue: 13),
    ChartSampleData(x: DateTime(2015, 1, 2, 2), yValue: 12),
    ChartSampleData(x: DateTime(2015, 1, 3, 3), yValue: 08),
    ChartSampleData(x: DateTime(2015, 1, 4, 4), yValue: 12),
    ChartSampleData(x: DateTime(2015, 1, 5, 5), yValue: 1),
    ChartSampleData(x: DateTime(2015, 1, 6, 6), yValue: 12),
    ChartSampleData(x: DateTime(2015, 1, 7, 7), yValue: 1),
    ChartSampleData(x: DateTime(2015, 1, 8, 8), yValue: 12),
    ChartSampleData(x: DateTime(2015, 1, 9, 9), yValue: 16),
    ChartSampleData(x: DateTime(2015, 1, 10, 10), yValue: 1),
  ];

  TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _tooltipBehavior =  TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Center(
          //Initialize the chart widget
          child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(


                  tooltipBehavior: _tooltipBehavior,
                  backgroundColor: Colors.white,
                  //Specifying date time interval type as hours
                  primaryXAxis: DateTimeAxis(
                    //majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      intervalType: DateTimeIntervalType.days),
                  series: <ChartSeries<ChartSampleData, DateTime>>[
                    LineSeries<ChartSampleData, DateTime>(
                        dataSource: chartData,
                        xValueMapper: (ChartSampleData sales, _) => sales.x,
                        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                        name: 'Sales',
                        enableTooltip: true

                    )
                  ])),
        ));
  }
}
class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime x;
  final double yValue;
}


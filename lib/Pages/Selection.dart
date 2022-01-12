import 'package:flutter_map_marker_animation_example/Pages/SpeedReports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
//import 'package:i18n_extension/i18n_widget.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart';

// class ChartCustomYAxis extends StatelessWidget {
//   final List<MyRow> dates;
//
//   ChartCustomYAxis({
//     this.dates,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final myNumericFormatter =
//         BasicNumericTickFormatterSpec.fromNumberFormat(NumberFormat.compact());
//     return TimeSeriesChart(_createSampleData(),
//         animate: true,
//         primaryMeasureAxis:
//             NumericAxisSpec(tickFormatterSpec: myNumericFormatter),
//         domainAxis: DateTimeAxisSpec(
//             tickFormatterSpec: AutoDateTimeTickFormatterSpec(
//                 day: TimeFormatterSpec(
//                     format: 'd', transitionFormat: 'yyyy-MM-dd HH:mm:ss'))));
//   }
//
//   List<Series<MyRow, DateTime>> _createSampleData() {
//     return [
//       Series<MyRow, DateTime>(
//         id: 'Cost',
//         domainFn: (MyRow row, _) => row.timeStamp,
//         measureFn: (MyRow row, _) => row.cost,
//         data: dates,
//       )
//     ];
//   }
// }
class StaticClass{

 static bool showTruck=false;
}
class ParkedMarkers {
  static List<LatLng> putMarkers = [];
  static List time = [];
  static List idleTime = [];
  static List parkedTimeGraph = [];
  static List idleTimeGraph = [];

}







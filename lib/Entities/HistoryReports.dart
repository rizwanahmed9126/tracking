class HistoryReport {
  String vRN;
  String time;
  String ignitionOn;
  String landmark;
  double mileage;
  String time1;
  String ignitionOff;
  String landmark1;
  double mileage1;
  double distanceTravel;
  String tripDuration;
  double totalTiming;
  Null hour;
  Null min;

  HistoryReport(
      {this.vRN,
        this.time,
        this.ignitionOn,
        this.landmark,
        this.mileage,
        this.time1,
        this.ignitionOff,
        this.landmark1,
        this.mileage1,
        this.distanceTravel,
        this.tripDuration,
        this.totalTiming,
        this.hour,
        this.min});

  HistoryReport.fromJson(Map<String, dynamic> json) {
    vRN = json['VRN'];
    time = json['Time'];
    ignitionOn = json['IgnitionOn'];
    landmark = json['Landmark'];
    mileage = json['Mileage'];
    time1 = json['Time1'];
    ignitionOff = json['IgnitionOff'];
    landmark1 = json['Landmark1'];
    mileage1 = json['Mileage1'];
    distanceTravel = json['DistanceTravel'];
    tripDuration = json['TripDuration'];
    totalTiming = json['TotalTiming'];
    hour = json['Hour'];
    min = json['Min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VRN'] = this.vRN;
    data['Time'] = this.time;
    data['IgnitionOn'] = this.ignitionOn;
    data['Landmark'] = this.landmark;
    data['Mileage'] = this.mileage;
    data['Time1'] = this.time1;
    data['IgnitionOff'] = this.ignitionOff;
    data['Landmark1'] = this.landmark1;
    data['Mileage1'] = this.mileage1;
    data['DistanceTravel'] = this.distanceTravel;
    data['TripDuration'] = this.tripDuration;
    data['TotalTiming'] = this.totalTiming;
    data['Hour'] = this.hour;
    data['Min'] = this.min;
    return data;
  }
}
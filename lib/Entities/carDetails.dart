class CarDetails {
  int vehicleId;
  double latitude;
  double longitude;
  double speed;
  String gPSStatus;
  String referenceLocation;
  String receiveDateTime;
  String visibleSatelites;
  int altitude;
  int angle;
  String iMEI;
  String alarmDetails;
  String iOId;
  bool ignitionStatus;
  bool batteryTemperStatus;
  String vehicleStatus;
  double mileage;
  String fuelStatus;
  String temperatureStatus;
  bool referenceLocationStatus;
  String serverDateTime;
  String deviceAlarm;
  String deviceStatus;
  bool unitCasingTemper;
  bool harshBreak;
  String fuelSensor;
  String fuelSensorTemp;
  String fuelSensor2;
  String fuelSensorTemp2;
  String fuelSensor3;
  String fuelSensorTemp3;
  String fuelSensorLastUpdate;
  bool doorAlert;
  bool panicAlert;
  bool seatBelt;
  String rFID;
  double idleValue;
  String trackerID;

  CarDetails(
      {this.vehicleId,
        this.latitude,
        this.longitude,
        this.speed,
        this.gPSStatus,
        this.referenceLocation,
        this.receiveDateTime,
        this.visibleSatelites,
        this.altitude,
        this.angle,
        this.iMEI,
        this.alarmDetails,
        this.iOId,
        this.ignitionStatus,
        this.batteryTemperStatus,
        this.vehicleStatus,
        this.mileage,
        this.fuelStatus,
        this.temperatureStatus,
        this.referenceLocationStatus,
        this.serverDateTime,
        this.deviceAlarm,
        this.deviceStatus,
        this.unitCasingTemper,
        this.harshBreak,
        this.fuelSensor,
        this.fuelSensorTemp,
        this.fuelSensor2,
        this.fuelSensorTemp2,
        this.fuelSensor3,
        this.fuelSensorTemp3,
        this.fuelSensorLastUpdate,
        this.doorAlert,
        this.panicAlert,
        this.seatBelt,
        this.rFID,
        this.idleValue,
        this.trackerID});

  CarDetails.fromJson(Map<String, dynamic> json) {
    vehicleId = json['VehicleId'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    speed = json['Speed'];
    gPSStatus = json['GPSStatus'];
    referenceLocation = json['ReferenceLocation'];
    receiveDateTime = json['ReceiveDateTime'];
    visibleSatelites = json['VisibleSatelites'];
    altitude = json['Altitude'];
    angle = json['Angle'];
    iMEI = json['IMEI'];
    alarmDetails = json['AlarmDetails'];
    iOId = json['IOId'];
    ignitionStatus = json['IgnitionStatus'];
    batteryTemperStatus = json['BatteryTemperStatus'];
    vehicleStatus = json['VehicleStatus'];
    mileage = json['Mileage'];
    fuelStatus = json['FuelStatus'];
    temperatureStatus = json['TemperatureStatus']??' ';
    referenceLocationStatus = json['ReferenceLocationStatus'];
    serverDateTime = json['ServerDateTime'];
    deviceAlarm = json['DeviceAlarm']??" ";
    deviceStatus = json['DeviceStatus'];
    unitCasingTemper = json['UnitCasingTemper'];
    harshBreak = json['HarshBreak']??false;
    fuelSensor = json['FuelSensor'];
    fuelSensorTemp = json['FuelSensorTemp'];
    fuelSensor2 = json['FuelSensor2'];
    fuelSensorTemp2 = json['FuelSensorTemp2'];
    fuelSensor3 = json['FuelSensor3'];
    fuelSensorTemp3 = json['FuelSensorTemp3'];
    fuelSensorLastUpdate = json['FuelSensorLastUpdate'];
    doorAlert = json['DoorAlert'];
    panicAlert = json['PanicAlert'];
    seatBelt = json['SeatBelt'];
    rFID = json['RFID'];
    idleValue = json['IdleValue'];
    trackerID = json['TrackerID']??' ';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VehicleId'] = this.vehicleId;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Speed'] = this.speed;
    data['GPSStatus'] = this.gPSStatus;
    data['ReferenceLocation'] = this.referenceLocation;
    data['ReceiveDateTime'] = this.receiveDateTime;
    data['VisibleSatelites'] = this.visibleSatelites;
    data['Altitude'] = this.altitude;
    data['Angle'] = this.angle;
    data['IMEI'] = this.iMEI;
    data['AlarmDetails'] = this.alarmDetails;
    data['IOId'] = this.iOId;
    data['IgnitionStatus'] = this.ignitionStatus;
    data['BatteryTemperStatus'] = this.batteryTemperStatus;
    data['VehicleStatus'] = this.vehicleStatus;
    data['Mileage'] = this.mileage;
    data['FuelStatus'] = this.fuelStatus;
    data['TemperatureStatus'] = this.temperatureStatus;
    data['ReferenceLocationStatus'] = this.referenceLocationStatus;
    data['ServerDateTime'] = this.serverDateTime;
    data['DeviceAlarm'] = this.deviceAlarm;
    data['DeviceStatus'] = this.deviceStatus;
    data['UnitCasingTemper'] = this.unitCasingTemper;
    data['HarshBreak'] = this.harshBreak;
    data['FuelSensor'] = this.fuelSensor;
    data['FuelSensorTemp'] = this.fuelSensorTemp;
    data['FuelSensor2'] = this.fuelSensor2;
    data['FuelSensorTemp2'] = this.fuelSensorTemp2;
    data['FuelSensor3'] = this.fuelSensor3;
    data['FuelSensorTemp3'] = this.fuelSensorTemp3;
    data['FuelSensorLastUpdate'] = this.fuelSensorLastUpdate;
    data['DoorAlert'] = this.doorAlert;
    data['PanicAlert'] = this.panicAlert;
    data['SeatBelt'] = this.seatBelt;
    data['RFID'] = this.rFID;
    data['IdleValue'] = this.idleValue;
    data['TrackerID'] = this.trackerID;
    return data;
  }


}
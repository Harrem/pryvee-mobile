import 'package:pryvee/data/data_source_local.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

Future<void> getCurrentLocation() async {
  await Geolocator.requestPermission();
  LocationSettings locationSettings;
  if (Platform.isAndroid)
    locationSettings = AndroidSettings(accuracy: LocationAccuracy.best, distanceFilter: 10, forceLocationManager: true, intervalDuration: const Duration(seconds: 60));
  else if (Platform.isIOS)
    locationSettings = AppleSettings(accuracy: LocationAccuracy.best, distanceFilter: 100, pauseLocationUpdatesAutomatically: true);
  else
    locationSettings = LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 100);
  Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) async {
    if (position is Position) addLocalLocationToSP("${position.latitude}_${position.longitude}");
  });
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pryvee/data/data_source_local.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

Future<void> getCurrentLocation() async {
  await Geolocator.requestPermission();
  LocationSettings locationSettings;
  if (Platform.isAndroid)
    locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 60));
  else if (Platform.isIOS)
    locationSettings = AppleSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true);
  else
    locationSettings =
        LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 100);
  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) async {
    if (position is Position)
      addLocalLocationToSP("${position.latitude}_${position.longitude}");
  });
}

Future<String> getAddress(long, lat) async {
  var apiKey = "YOUR_API_KEY";
  var url =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiKey";

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var address = json["results"][0]["formatted_address"];
    return address;
  } else {
    print("Error getting address");
    return null;
  }
}

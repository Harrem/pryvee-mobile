import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pryvee/config/app_config.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController mapController;
  bool isLoading = false;

  LatLng _center = LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: {
              Marker(
                markerId: MarkerId("my-location"),
                position: _center,
                infoWindow: InfoWindow(
                  title: "Location",
                ),
                icon: BitmapDescriptor.defaultMarker,
              )
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            onTap: (latLng) {
              setState(() {
                _center = latLng;
              });
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // padding: EdgeInsets.all(20),
                constraints: BoxConstraints(maxWidth: 600),
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await _getCurrentLocation();
                    mapController.moveCamera(CameraUpdate.newLatLng(_center));
                    setState(() {
                      isLoading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      padding: EdgeInsets.all(13),
                      elevation: 0,
                      shape: StadiumBorder()),
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator())
                      : Text(
                          "Get Your Location",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                // padding: EdgeInsets.all(20),
                constraints: BoxConstraints(maxWidth: 600),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop<LatLng>(_center);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(13),
                      elevation: 0,
                      shape: StadiumBorder()),
                  child: Text("Done"),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      var location = Location();
      var curLoc = await location.getLocation();
      var latLng = LatLng(curLoc.latitude, curLoc.longitude);
      setState(() {
        _center = latLng;
      });
    } catch (e) {
      print(e);
    }
  }
}

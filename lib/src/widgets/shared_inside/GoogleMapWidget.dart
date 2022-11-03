import 'package:pryvee/src/providers_utils/theme_notifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pryvee/src/utils/theme_utility.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//ignore: must_be_immutable
class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({
    Key key,
    @required this.initialCameraPosition,
    @required this.initialLatLng,
    @required this.onCameraMove,
    @required this.circleSet,
    @required this.markerSet,
    @required this.onTap,
    @required this.zoom,
  }) : super(key: key);
  void Function(CameraPosition) onCameraMove;
  CameraPosition initialCameraPosition;
  void Function(LatLng) onTap;
  bool rotateGesturesEnabled;
  Set<Circle> circleSet;
  Set<Marker> markerSet;
  LatLng initialLatLng;
  double zoom;

  @override
  _GoogleMapWidget createState() => _GoogleMapWidget();
}

class _GoogleMapWidget extends State<GoogleMapWidget> {
  Completer<GoogleMapController> googleMapController = new Completer();
  String darkThemeMapStyle;
  String lightThemeMapStyle;

  @override
  void dispose() {
    this.googleMapController.complete();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
       rootBundle.loadString('map-style/dark_theme_map_style.json').then((value) => setState(() => this.darkThemeMapStyle = value));
      rootBundle.loadString('map-style/light_theme_map_style.json').then((value) => setState(() => this.lightThemeMapStyle = value));
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Provider.of<ThemeNotifier>(context, listen: false).getLocalTheme();
    return (this.lightThemeMapStyle == null)
        ? SizedBox()
        : GoogleMap(
            initialCameraPosition: widget.initialCameraPosition,
            onCameraMove: widget.onCameraMove, 
            myLocationButtonEnabled: false,
            rotateGesturesEnabled:  true,
            scrollGesturesEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
            circles: widget.circleSet,
            markers: widget.markerSet,
            mapToolbarEnabled: false,
            myLocationEnabled: false,
            mapType: MapType.normal,
            compassEnabled: false,
            onTap: widget.onTap,
            onMapCreated: (GoogleMapController controller) {
              this.googleMapController.complete(controller);
              this.googleMapController.future.then((value) => value.setMapStyle((localTheme == darkTheme) ? this.darkThemeMapStyle : this.lightThemeMapStyle));
              setState(() {});
            },
          );
  }
}

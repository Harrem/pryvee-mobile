import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/utils/custom_map_marker/marker_generator.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/GoogleMapWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pryvee/src/utils/location_utility.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';

// ignore: must_be_immutable
class PickLocationFromMapWidget extends StatefulWidget {
  PickLocationFromMapWidget(
      {Key key, @required this.refreshTheView, @required this.user})
      : super(key: key);
  ValueChanged<LatLng> refreshTheView;
  UserData user;
  @override
  _PickLocationFromMapWidget createState() => _PickLocationFromMapWidget();
}

class _PickLocationFromMapWidget extends State<PickLocationFromMapWidget> {
  Completer<GoogleMapController> googleMapController = Completer();
  LatLng localLocation = LatLng(0.0, 0.0);
  CameraPosition cameraPosition;
  String checkAdressLine = '';
  Marker currentMarker;

  Future<void> _initState() async {
    this.localLocation = await getLocalLocationFromSP();
    MarkerGenerator(
            [getUserMarkerWidget()],
            (bitmaps) => setState(() => this.currentMarker =
                getUserUint8ListAsMarker(bitmaps.first, this.localLocation)))
        .generate(context);
    this.cameraPosition =
        CameraPosition(target: this.localLocation, zoom: 18.0);
    setState(() {});
  }

  Marker getUserUint8ListAsMarker(Uint8List uint8list, LatLng latLng) => Marker(
        icon: BitmapDescriptor.fromBytes(uint8list),
        markerId: MarkerId(UniqueKey().toString()),
        position: latLng,
      );

  void _updateCameraPosition(CameraPosition _position) {
    cameraPosition = _position;
    MarkerGenerator(
            [getUserMarkerWidget()],
            (bitmaps) => setState(() => this.currentMarker =
                getUserUint8ListAsMarker(bitmaps.first, _position.target)))
        .generate(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _initState();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: (this.localLocation == null || this.currentMarker == null)
            ? SizedBox()
            : Column(
                children: [
                  Expanded(
                    child: GoogleMapWidget(
                      onCameraMove: (p) => _updateCameraPosition(p),
                      initialCameraPosition: cameraPosition,
                      initialLatLng: this.localLocation,
                      markerSet: {currentMarker},
                      circleSet: {},
                      onTap: null,
                      zoom: 16.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            height: 4.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            IconButton(
                              splashRadius: 25.0,
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 20.0,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                "Choisir un empaçement",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 8.0),
                        CommunTextButtonWidget(
                          color: APP_COLOR,
                          shape: StadiumBorder(),
                          onPressed: () {
                            widget.refreshTheView(this.localLocation);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Confirmer",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                  TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                          ),
                        ),
                        CommunTextButtonWidget(
                          color: Colors.transparent,
                          shape: StadiumBorder(
                              side: BorderSide(color: APP_COLOR, width: 1.0)),
                          onPressed: () {
                            getCurrentLocation();
                            _initState();
                          },
                          child: Text(
                            "Actualiser ma localisation",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                  TextStyle(
                                    color: APP_COLOR,
                                  ),
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      );
  Widget getUserMarkerWidget() => Stack(
        alignment: Alignment.center,
        children: [
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.circular(100.0),
            edgeInsetsGeometry: EdgeInsets.zero,
            color: APP_COLOR.withOpacity(0.2),
            height: 180.0,
            width: 180.0,
            child: SizedBox(),
          ),
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.circular(100.0),
            edgeInsetsGeometry: EdgeInsets.zero,
            color: APP_COLOR.withOpacity(0.3),
            height: 140.0,
            width: 140.0,
            child: SizedBox(),
          ),
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.circular(100.0),
            edgeInsetsGeometry: EdgeInsets.zero,
            color: APP_COLOR.withOpacity(0.4),
            height: 120.0,
            width: 120.0,
            child: SizedBox(),
          ),
          SizedBox(
            height: 80.0,
            width: 80.0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).focusColor,
              backgroundImage: NetworkImage(
                widget.user.picture,
              ),
            ),
          ),
        ],
      );
}

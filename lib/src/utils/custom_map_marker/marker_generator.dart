import 'package:pryvee/src/utils/custom_map_marker/marker_helper.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class MarkerGenerator {
  MarkerGenerator(this.markerWidgets, this.callback);
  final Function(List<Uint8List>) callback;
  final List<Widget> markerWidgets;

  void generate(BuildContext context) => WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));

  void afterFirstLayout(BuildContext context) => addOverlay(context);

  void addOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry entry;
    entry = OverlayEntry(
      maintainState: true,
      builder: (context) => MarkerHelper(
        markerWidgets: markerWidgets,
        callback: (List<Uint8List> bitmapList) {
          callback.call(bitmapList);
          entry.remove();
        },
      ),
    );
    overlayState.insert(entry);
  }
}

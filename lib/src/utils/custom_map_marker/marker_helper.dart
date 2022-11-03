import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class MarkerHelper extends StatefulWidget {
  const MarkerHelper({Key key, @required this.markerWidgets, @required this.callback}) : super(key: key);
  final List<Widget> markerWidgets;
  final Function(List<Uint8List>) callback;

  @override
  __MarkerHelper createState() => __MarkerHelper();
}

class __MarkerHelper extends State<MarkerHelper> with AfterLayoutMixin {
  List<GlobalKey> globalKeys = [];

  @override
  void afterFirstLayout(BuildContext context) => _getBitmaps(context).then((list) => widget.callback(list));

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width, 0),
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: widget.markerWidgets.map((i) {
              GlobalKey globalKey = GlobalKey();
              globalKeys.add(globalKey);
              return RepaintBoundary(
                key: globalKey,
                child: i,
              );
            }).toList(),
          ),
        ),
      );

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    var futures = globalKeys.map((key) => _getUint8List(key));
    return Future.wait(futures);
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary = markerKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}

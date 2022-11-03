import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductItemWidgetShimmer extends StatelessWidget {
  ProductItemWidgetShimmer({Key key, @required this.edgeInsetsGeometry}) : super(key: key);
  EdgeInsetsGeometry edgeInsetsGeometry;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Theme.of(context).focusColor,
        highlightColor: Colors.transparent,
        enabled: true,
        child: MasonryGridView.count(
          padding: this.edgeInsetsGeometry,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          crossAxisCount: 2,
          shrinkWrap: true,
          primary: false,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 150.0,
                height: 10.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 80.0,
                height: 10.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 40.0,
                height: 10.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              ),
            ],
          ),
        ),
      );
}

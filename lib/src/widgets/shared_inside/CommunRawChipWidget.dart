import 'package:pryvee/data/data_source_const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunRawChipWidget extends StatelessWidget {
  CommunRawChipWidget({
    Key key,
    @required this.label,
    @required this.selected,
    @required this.onSelected,
   }) : super(key: key);
  String label;
  bool selected;
 
  void Function(bool) onSelected;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 34.0,
        child: RawChip(
           label: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          labelStyle: Theme.of(context).textTheme.bodyText1,
          backgroundColor: Theme.of(context).focusColor,
          selectedColor: Theme.of(context).focusColor,
          selectedShadowColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.all(7.0),
          onSelected: this.onSelected,
          checkmarkColor: APP_COLOR,
          selected: this.selected,
          shape: StadiumBorder(),
          showCheckmark: true,
        ),
      );
}

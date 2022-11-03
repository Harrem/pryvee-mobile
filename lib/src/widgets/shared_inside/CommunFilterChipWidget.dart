import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunFilterChipWidget extends StatelessWidget {
  CommunFilterChipWidget({Key key, @required this.selected, @required this.color, @required this.onSelected}) : super(key: key);
  bool selected;
  Color color;
  void Function(bool) onSelected;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 38.0,
        height: 38.0,
        child: FilterChip(
            label: Text(''),
            padding: EdgeInsets.all(7.0),
            backgroundColor: this.color,
            selectedColor: this.color,
            selected: this.selected,
            shape: StadiumBorder(),
            selectedShadowColor: Colors.transparent,
            shadowColor: Colors.transparent,
            checkmarkColor: (this.color == Colors.white) ? Colors.black : Colors.white,
            onSelected: onSelected),
      );
}

import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearchBarWidget extends StatelessWidget {
  CustomSearchBarWidget({Key key, @required this.searchTextEditingController, this.edgeInsetsGeometry}) : super(key: key);
  TextEditingController searchTextEditingController;
  EdgeInsetsGeometry edgeInsetsGeometry;

  @override
  Widget build(BuildContext context) => Container(
      margin: this.edgeInsetsGeometry ?? EdgeInsets.zero,
      child: CommunChipWidget(
          edgeInsetsGeometry: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          borderRadiusGeometry: BorderRadius.circular(12.0),
          color: Theme.of(context).focusColor,
          height: 42.0,
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 18.0,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              ),
              SizedBox(width: 6.0),
              Expanded(
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: this.searchTextEditingController,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                          ),
                        ),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          )));
}

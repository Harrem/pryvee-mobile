import 'package:pryvee/config/app_config.dart' as config;
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmptyResultWidget extends StatelessWidget {
  EmptyResultWidget({Key key, @required this.edgeInsetsGeometry}) : super(key: key);
  EdgeInsetsGeometry edgeInsetsGeometry;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: config.App(context).appHeight(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      APP_COLOR,
                      APP_COLOR.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Icon(
                  UiIcons.loupe,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).focusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: 0.8,
            child: Text(
              "We couldn't find any matches for your query!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
            ),
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text(
              'Double check your search for any typos or spelling errors - or try a different search term.\n\nAlso keep in mind, some products may only be available in our stores, not online.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

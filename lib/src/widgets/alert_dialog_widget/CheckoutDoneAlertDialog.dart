import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';

class CheckoutDoneAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.greenAccent,
                      Colors.green,
                    ],
                  ),
                ),
                child: Icon(
                  UiIcons.checked,
                  color: Colors.white,
                  size: 60.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Your payment was successfully processed',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 20.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
              ),
              SizedBox(height: 20.0),
              CommunTextButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/UserTabs', arguments: 1);
                },
                color: APP_COLOR,
                shape: StadiumBorder(),
                child: Text(
                  'Your Orders',
                  style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(
                          color: Colors.white,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
}

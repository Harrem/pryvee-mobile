import 'package:flutter/material.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/src/screens/user_inside/user_tabs.dart';

class SocialMediaWidget extends StatelessWidget {
  SocialMediaWidget({
    Key key,
  }) : super(key: key);
  final DataSourceSet dataSource = DataSourceSet();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 46.0,
          height: 46.0,
          child: InkWell(
            onTap: () async {
              await dataSource.registerWithGoogleAPI(context).then((value) {
                debugPrint("sign In suceeded");
                if (value != null) {
                  if (value.phoneNumber == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, '/UserTabs');
                  }
                }
              });
            },
            child: Image.asset('img/google.png'),
          ),
        ),
        SizedBox(width: 6.0),
        SizedBox(
          width: 46.0,
          height: 46.0,
          child: InkWell(
            onTap: () {},
            child: Image.asset('img/facebook.png'),
          ),
        ),
      ],
    );
  }
}

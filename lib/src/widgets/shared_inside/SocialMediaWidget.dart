import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 46.0,
          height: 46.0,
          child: InkWell(
            onTap: () {},
            child: Image.asset('img/facebook.png'),
          ),
        ),
        SizedBox(width: 6.0),
        SizedBox(
          width: 46.0,
          height: 46.0,
          child: InkWell(
            onTap: () {},
            child: Image.asset('img/twitter.png'),
          ),
        ),
        SizedBox(width: 6.0),
        SizedBox(
          width: 46.0,
          height: 46.0,
          child: InkWell(
            onTap: () {},
            child: Image.asset('img/google.png'),
          ),
        ),
      ],
    );
  }
}

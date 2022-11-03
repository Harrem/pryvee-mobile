import 'package:pryvee/data/data_source_get.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserAvatarButtonWidget extends StatefulWidget {
  String profileUrl;
  UserAvatarButtonWidget({Key key, this.profileUrl}) : super(key: key);

  @override
  _UserAvatarButtonWidget createState() => _UserAvatarButtonWidget();
}

class _UserAvatarButtonWidget extends State<UserAvatarButtonWidget> {
  DataSourceGet apiGet = DataSourceGet();
  UserData user;

  @override
  void initState() {
    super.initState();
    if (this.mounted) {}
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 30.0,
        height: 30.0,
        margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: () =>
              Navigator.of(context).pushNamed('/UserTabs', arguments: 2),
          child: this.user == null
              ? CircleAvatar(
                  backgroundColor: Theme.of(context).focusColor,
                  backgroundImage: NetworkImage(
                    widget.profileUrl ??
                        'https://www.shareicon.net/data/512x512/2017/01/06/868320_people_512x512.png',
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Theme.of(context).focusColor,
                  backgroundImage: NetworkImage(this.user.picture),
                ),
        ),
      );
}

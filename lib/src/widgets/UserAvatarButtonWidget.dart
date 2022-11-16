import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserAvatarButtonWidget extends StatefulWidget {
  String profileUrl;
  UserAvatarButtonWidget({Key key, this.profileUrl}) : super(key: key);

  @override
  _UserAvatarButtonWidget createState() => _UserAvatarButtonWidget();
}

class _UserAvatarButtonWidget extends State<UserAvatarButtonWidget> {
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
            child: CircleAvatar(
              backgroundColor: Theme.of(context).focusColor,
              backgroundImage: widget.profileUrl == null
                  ? AssetImage("img/defaultProfilePic.png")
                  : NetworkImage(widget.profileUrl),
            )),
      );
}

import 'package:pryvee/src/widgets/shared_inside/CustomInkWell.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserItemWidget extends StatelessWidget {
  UserItemWidget({Key key, @required this.user}) : super(key: key);
  UserData user;

  @override
  Widget build(BuildContext context) => CustomInkWell(
        onTap: () => {},
        child: Row(
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    this.user.picture,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    this.user.fullName,
                    style: Theme.of(context).textTheme.headline2.merge(
                          TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                  ),
                  Text(
                    this.user.email,
                    style: Theme.of(context).textTheme.headline2.merge(
                          TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

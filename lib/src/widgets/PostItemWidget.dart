import 'package:provider/provider.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

// ignore: must_be_immutable
class PostItemWidget extends StatelessWidget {
  PostItemWidget({Key key, this.post, this.user, this.refreshTheView})
      : super(key: key);
  UserData user;
  Post post;
  final Function refreshTheView;

  @override
  Widget build(BuildContext context) {
    return CommunChipWidget(
      color: Theme.of(context).focusColor.withOpacity(0.4),
      borderRadiusGeometry: BorderRadius.circular(8.0),
      edgeInsetsGeometry: EdgeInsets.zero,
      gradient: LinearGradient(
        begin: const FractionalOffset(0.0, 0.8),
        end: const FractionalOffset(0.8, 1.0),
        tileMode: TileMode.clamp,
        colors: [
          APP_COLOR,
          Colors.purple,
          Colors.pink,
        ],
        stops: [
          0.0,
          0.8,
          1.0,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            edgeInsetsGeometry: EdgeInsets.all(10.0),
            color: Theme.of(context).focusColor,
            child: Row(
              children: [
                SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).focusColor,
                    backgroundImage: NetworkImage(
                      user != null
                          ? user.picture ?? DEFAULT_USER_PICTURE
                          : DEFAULT_USER_PICTURE,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${user.fullName}',
                        style: Theme.of(context).textTheme.headline2.merge(
                              TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        '${post.datingAddress.address + ", " ?? ""}${post.datingAddress.city + ", " ?? ""}${post.datingAddress.country ?? ""}${", " + post.datingAddress.postCode ?? ""}.',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                    CommunChipWidget(
                      edgeInsetsGeometry:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      borderRadiusGeometry: BorderRadius.circular(100.0),
                      color: Colors.black,
                      child: Text(
                        'See on maps'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(
                      Icons.linear_scale_rounded,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        '22.3 KM Away',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(
                      Icons.car_crash_sharp,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        'USING • ${this.post.transport}',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  "I'am visiting ...".toUpperCase(),
                  style: Theme.of(context).textTheme.headline2.merge(
                        TextStyle(
                          fontSize: 12.0,
                          color: APP_COLOR,
                        ),
                      ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    SizedBox(
                      height: 60.0,
                      width: 60.0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).focusColor,
                        backgroundImage: NetworkImage(
                            this.post.pictureUrl == null
                                ? this.post.pictureUrl
                                : DEFAULT_USER_PICTURE),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            this.post.fullName,
                            style: Theme.of(context).textTheme.headline2.merge(
                                  TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                          ),
                          Text(
                            this.post.phoneNumber,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 2.0),
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: [
                              CommunChipWidget(
                                edgeInsetsGeometry: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                borderRadiusGeometry:
                                    BorderRadius.circular(100.0),
                                color: Colors.transparent,
                                boxBorder: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                                child: Text(
                                  'Call May',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(
                                        TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                ),
                              ),
                              CommunChipWidget(
                                edgeInsetsGeometry: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                borderRadiusGeometry:
                                    BorderRadius.circular(100.0),
                                color: Colors.transparent,
                                boxBorder: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                                child: Text(
                                  'Report May',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(
                                        TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await Provider.of<PostProvider>(context,
                                  listen: false)
                              .deletePost(post)
                              .then((value) {
                            showToast(context, "Post removed successfully");
                          }).catchError((e) {
                            showToast(context, "Error: $e");
                          });
                          refreshTheView();
                        },
                        child: CommunChipWidget(
                          edgeInsetsGeometry: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12.0),
                          borderRadiusGeometry: BorderRadius.circular(8.0),
                          color: APP_COLOR,
                          child: Text(
                            'Remove Post'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                  TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/utils/contact_operations.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LivePostItemWidget extends StatefulWidget {
  LivePostItemWidget({Key key, @required this.post, @required this.userData})
      : super(key: key);
  Post post;
  UserData userData;

  @override
  State<LivePostItemWidget> createState() => _LivePostItemWidgetState();
}

class _LivePostItemWidgetState extends State<LivePostItemWidget> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return CommunChipWidget(
      color: Theme.of(context).focusColor.withOpacity(0.4),
      borderRadiusGeometry: BorderRadius.circular(8.0),
      edgeInsetsGeometry: EdgeInsets.zero,
      gradient: LinearGradient(
        begin: const FractionalOffset(0.0, 0.8),
        end: const FractionalOffset(0.8, 1.0),
        tileMode: TileMode.clamp,
        colors: [
          Colors.pink,
          Colors.deepPurple,
          Colors.deepOrange,
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
                      widget.userData.picture ?? DEFAULT_USER_PICTURE,
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
                        widget.userData.fullName,
                        style: Theme.of(context).textTheme.headline2.merge(
                              TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                      ),
                      Text(
                        widget.userData.email,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  "${DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.fromMillisecondsSinceEpoch(widget.post.createdAt))}",
                  style: Theme.of(context).textTheme.headline1,
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
                        '${widget.post.datingAddress.toString()}',
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
                      Icons.car_crash_sharp,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        'Using ${widget.post.transport}',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onDoubleTap: () async {
                    await Clipboard.setData(
                            ClipboardData(text: widget.post.carPlateNumber))
                        .then((value) =>
                            showToast(context, "Copied to Clipboard!"));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.numbers,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          'Plate No: ${widget.post.carPlateNumber}',
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
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
                            widget.post.pictureUrl.isNotEmpty
                                ? widget.post.pictureUrl
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
                            '${widget.post.fullName}',
                            style: Theme.of(context).textTheme.headline2.merge(
                                  TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                          ),
                          Text(
                            "Phone No: ${widget.post.phoneNumber}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 2.0),
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ContactOperations.dail(
                                      widget.post.phoneNumber);
                                },
                                child: CommunChipWidget(
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
                                    'Call ${widget.post.fullName.split(' ')[0]}',
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
                                  'Report ${widget.post.fullName.split(' ')[0]}',
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
                        child: CommunChipWidget(
                          onTap: () {
                            Navigator.pushNamed(context, '/notification-page',
                                arguments: widget.post.notificationId);
                          },
                          edgeInsetsGeometry: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12.0),
                          borderRadiusGeometry: BorderRadius.circular(8.0),
                          color: APP_COLOR,
                          child: Text(
                            'In danger!'.toUpperCase(),
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    height: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Do you want to keep watching you?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Keep Watch"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Provider.of<PostProvider>(
                                                        context,
                                                        listen: false)
                                                    .deletePost(widget.post)
                                                    .then((value) => showToast(
                                                        context,
                                                        "Post Removed!"));
                                                Navigator.pop(context);
                                              },
                                              child: Text("Remove"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: CommunChipWidget(
                          edgeInsetsGeometry: EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12.0),
                          boxBorder: Border.all(color: APP_COLOR, width: 1.0),
                          borderRadiusGeometry: BorderRadius.circular(8.0),
                          color: Colors.transparent,
                          child: Text(
                            "I'am safe".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                  TextStyle(
                                    color: APP_COLOR,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
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

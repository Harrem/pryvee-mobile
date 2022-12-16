import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/widgets/LivePostItemWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:flutter/material.dart';
import 'add_operations/add_new_post.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TextEditingController searchTextEditingController = TextEditingController();
  bool isLoading = true;
  DataSourceGet apiGet = DataSourceGet();
  String localTimeZone;

  Future<void> getLocalTimeZone() async {
    localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  }

  refresh() {
    setState(() {});
    debugPrint("Refreshed");
  }

  @override
  void initState() {
    getLocalTimeZone();

    Provider.of<PostProvider>(context, listen: false)
        .fetchAllPostes(Provider.of<UserProvider>(context, listen: false).uid)
        .whenComplete(() {
      isLoading = false;
      if (mounted) setState(() {});
    });
    super.initState();
    if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            children: [
              Text(
                'PRYVEE',
                style: Theme.of(context).textTheme.headline2.merge(
                      TextStyle(
                        fontSize: 26.0,
                      ),
                    ),
              ),
              SizedBox(height: 4.0),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 24.0,
                spacing: 4.0,
                children: [
                  Text(
                    'Your secret best',
                    style: Theme.of(context).textTheme.headline2.merge(
                          TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                  ),
                  Text(
                    'Friend!',
                    style: Theme.of(context).textTheme.headline2.merge(
                          TextStyle(
                            fontSize: 20.0,
                            color: APP_COLOR,
                          ),
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              // CustomSearchBarWidget(
              //   searchTextEditingController: this.searchTextEditingController,
              // ),
              SizedBox(height: 12.0),
              SizedBox(height: 12.0),
              Provider.of<PostProvider>(context).livePosts.length == 0
                  ? Center(
                      child: Text("You don't have any posts yet"),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Running now'.toUpperCase(),
                            style: Theme.of(context).textTheme.headline2.merge(
                                  TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'See all'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline2.merge(
                                TextStyle(
                                  fontSize: 10.0,
                                  color: APP_COLOR,
                                ),
                              ),
                        ),
                      ],
                    ),
              SizedBox(height: 12.0),
              Provider.of<PostProvider>(context).livePosts != null
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.0),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount:
                          Provider.of<PostProvider>(context).livePosts.length,
                      itemBuilder: (context, index) {
                        if (Provider.of<PostProvider>(context)
                            .livePosts
                            .isNotEmpty)
                          Provider.of<PostProvider>(context).livePosts.forEach(
                              (livePost) async =>
                                  await checkNotification(livePost));
                        return LivePostItemWidget(
                          post: Provider.of<PostProvider>(context)
                              .livePosts[index],
                          userData: Provider.of<UserProvider>(context).userData,
                          notifyParent: refresh,
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "you don't have any posts yet!",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNewPosWidget())),
                          child: Text("Going out?"),
                        ),
                      ],
                    ),
              SizedBox(height: 12.0),
              // ElevatedButton(
              //     onPressed: () => AwesomeNotifications().cancel(43),
              //     child: Text("Cancel Test Notification")),
              // ElevatedButton(
              //     onPressed: () async => await createNoti(),
              //     child: Text("create Test notification"))
            ],
          );
  }
}

Future<void> createNoti() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 43,
          channelKey: 'basic_channel',
          title: 'Notification at every single minute',
          body:
              'This notification was schedule to repeat at every single minute.'),
      schedule: NotificationInterval(interval: 60, repeats: true),
      actionButtons: [
        NotificationActionButton(
            key: 'safe',
            label: "I'm safe",
            buttonType: ActionButtonType.DisabledAction),
        NotificationActionButton(
            key: 'danger',
            label: "I'm in danger",
            buttonType: ActionButtonType.Default),
      ]);
}

Future<void> checkNotification(Post post) async {
  await AwesomeNotifications().listScheduledNotifications().then(
    (value) async {
      if (value.isEmpty) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: post.notificationId,
            channelKey: 'schedule',
            title: "Are you safe?",
            body: "please choose if you're safe or not",
          ),
          schedule: NotificationInterval(
            interval: post.checkInterval * 60,
            repeats: true,
          ),
          actionButtons: [
            NotificationActionButton(
              key: 'safe',
              label: "I'm safe",
              buttonType: ActionButtonType.DisabledAction,
            ),
            NotificationActionButton(
              key: 'danger',
              label: "I'm in danger",
              buttonType: ActionButtonType.Default,
            ),
          ],
        );
      } else {
        var notiId = value.map((e) => e.content.id).toList();
        if (!notiId.contains(post.notificationId)) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: post.notificationId,
              channelKey: 'main_channel',
              title: "Are you safe?",
              body: "please choose if you're safe or not",
            ),
            schedule: NotificationInterval(interval: 65),
            actionButtons: [
              NotificationActionButton(
                key: 'safe',
                label: "I'm safe",
                buttonType: ActionButtonType.DisabledAction,
              ),
              NotificationActionButton(
                key: 'danger',
                label: "I'm in danger",
                buttonType: ActionButtonType.Default,
              ),
            ],
          );
        }
      }
    },
  );
}



//               } else {
//               return 
//             }
//           },
//         ),
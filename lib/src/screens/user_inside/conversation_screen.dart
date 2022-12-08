import 'package:provider/provider.dart';
import 'package:pryvee/src/models/conversation.dart';
import 'package:pryvee/src/models/with_user_data.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/user_inside/messaging.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomSearchBarWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:flutter/material.dart';

import '../../controllers/cloudStore.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen({Key key}) : super(key: key);
  @override
  _ConversationScreen createState() => _ConversationScreen();
}

class _ConversationScreen extends State<ConversationScreen> {
  TextEditingController searchTextEditingController =
      new TextEditingController();

  @override
  void initState() {
    if (mounted) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        CustomSearchBarWidget(
            searchTextEditingController: this.searchTextEditingController),
        SizedBox(height: 8.0),
        CommunChipWidget(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 500,
                        child: Card(
                          child: (ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            children: [
                              Text(
                                "Choose Contact",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Divider(),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      userProvider.userData.contacts.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        var toUser = userProvider
                                            .userData.contacts[index];
                                        var withUser = WithUserData(
                                            fullName: toUser.fullName,
                                            uid: toUser.uid,
                                            isActive: false,
                                            picture: toUser.picture);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MessageScreen(
                                                        toUser: withUser)));
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text(userProvider
                                            .userData.contacts[index].fullName),
                                      ),
                                    );
                                  })
                            ],
                          )),
                        ),
                      ),
                    ),
                  );
                }).then((value) => setState(() {}));
          },
          edgeInsetsGeometry:
              EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          borderRadiusGeometry: BorderRadius.circular(8.0),
          width: double.infinity,
          color: APP_COLOR,
          child: Text(
            'New Message',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.merge(
                  TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Text(
                'Chats'.toUpperCase(),
                style: Theme.of(context).textTheme.headline2.merge(
                      TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'See All'.toUpperCase(),
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
        FutureBuilder<List<WithUserData>>(
            future:
                getWU(userProvider.uid, userProvider.userData.conversations),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("loading convs"));
              }
              if (snapshot.hasError) {
                return Center(child: Text("error: ${snapshot.error}"));
              }
              if (snapshot.data == null) {
                return Center(child: Text("data is null"));
              }
              if (snapshot.data.isEmpty) {
                return Center(child: Text("data is null"));
              }
              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 8.0),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  debugPrint("length is ${snapshot.data.length}");
                  var withUser = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(
                            toUser: withUser,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              withUser.picture ?? DEFAULT_USER_PICTURE)),
                      title: Text(withUser.fullName),
                    ),
                  );
                },
              );
            })
      ],
    );
  }

  Future<List<WithUserData>> getWU(
      String uid, List<Conversation> conversations) async {
    List<WithUserData> list = [];

    for (var e in conversations) {
      debugPrint("executed");
      WithUserData withUser;
      if (e.user1 != Provider.of<UserProvider>(context, listen: false).uid) {
        withUser = await CloudStore.getWithUser(e.user1);
        list.add(withUser);
      } else {
        withUser = await CloudStore.getWithUser(e.user2);
        list.add(withUser);
        debugPrint("${withUser.fullName}");
      }
    }
    debugPrint("executed 1");
    return list;
  }
}

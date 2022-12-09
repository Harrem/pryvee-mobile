import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/src/models/conversation.dart';
import 'package:pryvee/src/models/with_user_data.dart';
import 'package:pryvee/src/providers_utils/conversation_provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/user_inside/messaging.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomSearchBarWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:flutter/material.dart';

import '../../controllers/cloudStore.dart';
import '../../models/message.dart';

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
    final p = Provider.of<ConversationProvider>(context, listen: false);
    p.conversations = Provider.of<UserProvider>(context, listen: false)
        .userData
        .conversations;
    if (mounted) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final conversationProvider = Provider.of<ConversationProvider>(context);
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
        ElevatedButton(
            onPressed: () {
              final p =
                  Provider.of<ConversationProvider>(context, listen: false);
              var cids = userProvider.userData.conversations
                  .map((e) => e.cid)
                  .toList();
              p.conversations = userProvider.userData.conversations;
              debugPrint("${p.conversations.first}");
              p.readMessage(p.conversations.first.cid);
            },
            child: Text("Test")),
        StreamBuilder(
          stream: conversationProvider.streamConversation(),
          initialData: userProvider.userData.conversations,
          builder: (BuildContext context,
              AsyncSnapshot<List<Conversation>> snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data.length : 0,
              itemBuilder: ((context, index) {
                return Text("${snapshot.data[index].cid}");
              }),
            );
          },
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
          future: getWU(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("error: ${snapshot.error}"));
            }
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return Center(child: Text("data is null"));
            }

            return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 8.0),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
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
                      subtitle: Text(
                        conversationProvider.conversations[index].lastMessage !=
                                null
                            ? userProvider
                                .userData.conversations[index].lastMessage.text
                            : "",
                        style: true
                            //  userProvider.userData.conversations[index]
                            // .lastMessage.didRead
                            ? TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                      ),
                      trailing: Text(
                          "${DateFormat.Hm().format(userProvider.userData.conversations[index].updatedDate)}"),
                    ),
                  );
                });
          },
        )
      ],
    );
  }

  Future<List<WithUserData>> getWU() async {
    final conversationProvider = Provider.of<ConversationProvider>(context);
    var conversations = conversationProvider.conversations;
    List<WithUserData> list = [];
    conversations.sort((a, b) =>
        b.updatedDate.millisecond.compareTo(a.updatedDate.millisecond));
    for (var e in conversations) {
      WithUserData withUser;
      if (e.user1 != conversationProvider.uid) {
        withUser = await conversationProvider.getWithUser(e.user1);
        list.add(withUser);
      } else {
        withUser = await conversationProvider.getWithUser(e.user2);
        list.add(withUser);
      }
    }
    return list;
  }
}

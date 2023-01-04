import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/providers_utils/conversation_provider.dart';
import 'package:pryvee/src/providers_utils/loading_provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';

import '../../models/conversation.dart';
import '../../models/message.dart';
import '../../utils/date_utility.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key key}) : super(key: key);
  // final WithUserData toUser;
  // final Conversation conversation;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String message = "";
  Message lastMessage;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserProvider>(context);
    final convPr = Provider.of<ConversationProvider>(context);
    return ChangeNotifierProvider<LoadingProvider>(
      create: (context) => LoadingProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(convPr.currentConv.fullName),
        ),
        body: checkConv(convPr.convs, convPr.currentConv.uid) == null
            ? CreateConversationWidget(
                refresh: refresh,
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(height: 0.1),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent),
                          child: StreamBuilder(
                            stream: convPr.readMessage(),
                            builder: (context,
                                AsyncSnapshot<List<Message>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  var messages = snapshot.data;
////////////////////////////////////////////////////////////////////

                                  // conversationProvider.currentConv.updatedDate =
                                  //     snapshot.data.first.sentDate;

                                  // conversationProvider.currentConv.lastMessage =
                                  //     snapshot.data.first;
////////////////////////////////////////////////////////////////////
                                  debugPrint("${messages.isEmpty}");
                                  return ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      debugPrint(messages.first.text);
                                      return messages[index].fromUid ==
                                              userActions.uid
                                          ? ChatBubbleSelf(
                                              message: messages[index],
                                              imageUrl:
                                                  userActions.userData.picture,
                                            )
                                          : ChatBubbleOther(
                                              message: messages[index],
                                              imageUrl: convPr.currentConv
                                                  .profilePictureUrl,
                                            );
                                    },
                                  );
                                }
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.1,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  onChanged: (value) {
                                    message = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "write message",
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () {
                                      if (message.isNotEmpty) {
                                        convPr.sendMessage(
                                            message,
                                            userActions.uid,
                                            userActions.userData.fullName,
                                            convPr.currentConv.nuid,
                                            userActions.userData.picture);
                                        _formKey.currentState.reset();
                                      }
                                      setState(() {
                                        if (message.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Fields are Empty'),
                                            ),
                                          );
                                        }
                                      });
                                      message = "";
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Conv checkConv(List<Conv> convs, String uid) {
    Conv conversation;

    for (var conv in convs) {
      if (conv.uid == uid) {
        conversation = conv;
      }
    }
    return conversation;
  }
}

class CreateConversationWidget extends StatelessWidget {
  const CreateConversationWidget({Key key, this.refresh}) : super(key: key);
  final Function refresh;
  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final conversationProvider = Provider.of<ConversationProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 300,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    conversationProvider.currentConv.profilePictureUrl),
                radius: 50,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    conversationProvider.currentConv.fullName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                "You don't have conversation with ${conversationProvider.currentConv.fullName}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 5),
              Text(
                "Start a conversation right now",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              loadingProvider.start();

              await conversationProvider
                  .createConversation(
                      userProvider.userData, conversationProvider.currentConv)
                  .then((value) {
                debugPrint("Conversation Created");
                debugPrint("Conversation id: ${value.cid}");
              });
              loadingProvider.stop();
              await Provider.of<ConversationProvider>(context, listen: false)
                  .initConv();
              refresh();
            },
            child: loadingProvider.isLoading
                ? const SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text("Start Conversation"),
          ),
        ),
      ],
    );
  }
}

class ChatBubbleSelf extends StatelessWidget {
  const ChatBubbleSelf({Key key, this.message, this.imageUrl})
      : super(key: key);
  final Message message;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerRight,
      widthFactor: 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: APP_COLOR, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.text,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  getDateFormetted(message.sentDate),
                  style: TextStyle(fontSize: 10, color: Colors.red[100]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ChatBubbleOther extends StatelessWidget {
  const ChatBubbleOther({Key key, this.message, this.imageUrl})
      : super(key: key);
  final Message message;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 15,
              ),
              const SizedBox(width: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(message.text,
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 5),
                    Text(
                      getDateFormetted(message.sentDate),
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

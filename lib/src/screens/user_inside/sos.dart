import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
import 'package:pryvee/src/utils/contact_operations.dart';

class SOSPage extends StatefulWidget {
  final dynamic nid;
  const SOSPage({Key key, @required this.nid}) : super(key: key);
  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  double height;
  double width;
  Post post;
  @override
  void initState() {
    post =
        Provider.of<PostProvider>(context, listen: false).getPost(widget.nid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      body: post == null
          ? Center(
              child: Text("Post not found"),
            )
          : ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 2) - 50,
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        color: Colors.red,
                        height: 150,
                        width: 150,
                        child: Image.asset('img/sos_animated.gif'),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Call Emergency",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "or contact ${post.trustedUserName} ASAP!",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 2) - 50,
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: [
                        SelectCard(
                          choice: choices[0],
                          onPressed: () => ContactOperations.dail('911'),
                        ),
                        SelectCard(
                          choice: choices[1],
                          onPressed: () => ContactOperations.dail(
                              post.trustedUserPhoneNumber),
                        ),
                        SelectCard(
                          choice: choices[2],
                          onPressed: () =>
                              ContactOperations.email(post.trustedUserEmail),
                        ),
                        SelectCard(
                          choice: choices[3],
                          onPressed: () => ContactOperations.sms(
                              post.trustedUserPhoneNumber),
                        ),
                        SelectCard(
                          choice: choices[4],
                          onPressed: () => postProvider.forwardInfo(post),
                        ),
                        SelectCard(
                          choice: choices[5],
                          onPressed: () {},
                        ),
                      ]),
                ),
              ],
            ),
    );
  }

  List<Choice> choices = <Choice>[
    Choice(title: 'Police', icon: Icons.local_police),
    Choice(title: 'Phone', icon: Icons.contact_phone_rounded),
    const Choice(title: 'Email', icon: Icons.email_rounded),
    const Choice(title: 'SMS', icon: Icons.sms_rounded),
    const Choice(title: 'Forward Info', icon: Icons.dataset),
    const Choice(title: 'Album', icon: Icons.photo_album),
  ];
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice, this.onPressed}) : super(key: key);
  final Choice choice;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 14.sp);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
          height: 100,
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: APP_COLOR),
            onPressed: onPressed,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(choice.icon, size: 30.sp, color: Colors.white),
              Text(choice.title, style: textStyle),
            ]),
          )),
    );
  }
}

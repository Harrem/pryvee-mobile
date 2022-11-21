import 'package:flutter/material.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SOSPage extends StatefulWidget {
  const SOSPage({Key key}) : super(key: key);
  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  double height;
  double width;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) - 50,
            child: Center(
                child: ClipOval(
              child: Container(
                color: Colors.red,
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: APP_COLOR),
                  onPressed: () {},
                  child: Icon(
                    Icons.sos_sharp,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            )),
          ),
          Text("Take Action Quickly"),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) - 50,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: List.generate(choices.length, (index) {
                return SelectCard(choice: choices[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Police', icon: Icons.local_police),
  const Choice(title: 'Phone', icon: Icons.contact_phone_rounded),
  const Choice(title: 'Email', icon: Icons.email_rounded),
  const Choice(title: 'SMS', icon: Icons.sms_rounded),
  const Choice(title: 'Forward Info', icon: Icons.dataset),
  const Choice(title: 'Album', icon: Icons.photo_album),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

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
            onPressed: () {},
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(choice.icon, size: 30.sp, color: Colors.white),
              Text(choice.title, style: textStyle),
            ]),
          )),
    );
  }
}

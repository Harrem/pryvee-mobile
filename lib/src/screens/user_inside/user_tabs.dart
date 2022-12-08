import 'package:provider/provider.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/src/screens/user_inside/conversation_screen.dart';
import 'package:pryvee/src/screens/user_inside/edit_operations/edit_account.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pryvee/src/widgets/UserAvatarButtonWidget.dart';
import 'package:pryvee/src/screens/user_inside/account.dart';
import 'package:pryvee/src/models/commun_select_model.dart';
import 'package:pryvee/src/screens/user_inside/posts.dart';
import 'package:pryvee/src/screens/user_inside/home.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';

import '../../providers_utils/user_data_provider.dart';

// ignore: must_be_immutable
class UserTabsWidget extends StatefulWidget {
  UserTabsWidget({Key key}) : super(key: key);

  @override
  _UserTabsWidget createState() => _UserTabsWidget();
}

class _UserTabsWidget extends State<UserTabsWidget>
    with TickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  TabController tabController;
  int currentTab = 0;
  bool isLoading = true;

  List<CommunSelectModel> communSelectModelList = [
    CommunSelectModel("Home", true),
    CommunSelectModel("Post", true),
    CommunSelectModel("Inbox", true),
    CommunSelectModel("Profile", true),
  ];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .initUserData()
        .then((user) {
      if (this.mounted)
        setState(() {
          isLoading = false;
        });
    });

    super.initState();
    tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            splashRadius: 24.0,
            icon: Icon(
              Icons.sort,
              size: 20.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            this.communSelectModelList.elementAt(currentTab).name,
            style: Theme.of(context).textTheme.headline4.merge(
                  TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  pryveeSignOut(context);
                },
                icon: Icon(
                  Icons.output_rounded,
                  color: Colors.black,
                )),
            isLoading
                ? UserAvatarButtonWidget()
                : UserAvatarButtonWidget(
                    profileUrl: userProvider.userData.picture)
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            HomeWidget(),
            PostsWidget(),
            ConversationScreen(),
            AccountWidget(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: CurvedNavigationBar(
            buttonBackgroundColor: APP_COLOR,
            backgroundColor: Colors.transparent,
            onTap: (int index) {
              tabController.index = index;
              debugPrint((tabController == null).toString());
            },
            index: currentTab,
            animationDuration: Duration(milliseconds: 400),
            animationCurve: Curves.easeOut,
            color: APP_COLOR,
            height: 50.0,
            items: <Widget>[
              Icon(
                UiIcons.home,
                size: 16.0,
                color: Colors.white,
              ),
              Icon(
                UiIcons.layers,
                size: 16.0,
                color: Colors.white,
              ),
              Icon(
                UiIcons.message_1,
                size: 16.0,
                color: Colors.white,
              ),
              Icon(
                UiIcons.user_1,
                size: 16.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

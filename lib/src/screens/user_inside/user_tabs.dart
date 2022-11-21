import 'package:provider/provider.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
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
  UserTabsWidget({Key key, @required this.currentTab}) : super(key: key);
  int currentTab = 0;
  int selectedTab = 0;
  Widget currentPage = HomeWidget();
  @override
  _UserTabsWidget createState() => _UserTabsWidget();
}

class _UserTabsWidget extends State<UserTabsWidget> {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  DataSourceGet apiGet = DataSourceGet();
  List<CommunSelectModel> communSelectModelList = [
    CommunSelectModel("Home", true),
    CommunSelectModel("Post", true),
    CommunSelectModel("Inbox", true),
    CommunSelectModel("Profile", true),
  ];

  void selectTab(int index) {
    widget.currentTab = index;
    widget.selectedTab = index;
    switch (index) {
      case 0:
        widget.currentPage = HomeWidget();
        break;
      case 1:
        widget.currentPage = PostsWidget();
        break;
      case 2:
        widget.currentPage = PostsWidget();
        break;
      case 3:
        widget.currentPage = AccountWidget();
        break;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(UserTabsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.currentTab = oldWidget.currentTab;
    widget.selectedTab = oldWidget.selectedTab;
    widget.currentPage = oldWidget.currentPage;
  }

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      selectTab(widget.currentTab);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    return FutureBuilder(
      future: userProvider.initUserData(),
      builder: ((context, snapshot) {
        bool isLoading = true;
        if (snapshot.connectionState == ConnectionState.waiting) {
          isLoading = true;
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            postProvider.fetchAllPostes(userProvider.uid);
            isLoading = false;
          } else {}
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditAccountWidget(
                            userData: userProvider.userData,
                          ))),
              splashRadius: 24.0,
              icon: Icon(
                Icons.sort,
                size: 20.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            title: Text(
              this.communSelectModelList.elementAt(widget.currentTab).name,
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
          body: SafeArea(
            child: widget.currentPage,
          ),
          bottomNavigationBar: SafeArea(
            child: CurvedNavigationBar(
              buttonBackgroundColor: APP_COLOR,
              backgroundColor: Colors.transparent,
              onTap: (int i) => this.selectTab(i),
              index: widget.selectedTab,
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
        );
      }),
    );
  }
}

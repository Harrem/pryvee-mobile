import 'package:provider/provider.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/user_inside/add_operations/add_new_post.dart';
import 'package:pryvee/src/widgets/PostItemWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomSearchBarWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:flutter/material.dart';

import '../../widgets/LivePostItemWidget.dart';
// ignore_for_file: must_be_immutable

class PostsWidget extends StatefulWidget {
  PostsWidget({Key key}) : super(key: key);
  @override
  _PostsWidgetState createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  var searchTextEditingController = new TextEditingController();

  refresh() {
    setState(() {});
    debugPrint("view Refreshed");
  }

//TODO: fix refreshing bug
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        CustomSearchBarWidget(
            searchTextEditingController: this.searchTextEditingController),
        SizedBox(height: 8.0),
        CommunChipWidget(
          onTap: () async => await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewPosWidget(
                        refreshParent: refresh,
                      ))),
          edgeInsetsGeometry:
              EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          borderRadiusGeometry: BorderRadius.circular(8.0),
          width: double.infinity,
          color: APP_COLOR,
          child: Text(
            'Add new post',
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
                'Recent post'.toUpperCase(),
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
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 8.0),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: postProvider.posts.length,
          itemBuilder: (context, index) {
            return PostItemWidget(
                post: postProvider.posts[index],
                user: userProvider.userData,
                refreshTheView: refresh);
          },
        )
      ],
    );
  }
}

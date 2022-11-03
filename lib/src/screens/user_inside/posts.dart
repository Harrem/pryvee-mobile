import 'package:pryvee/src/screens/user_inside/add_operations/add_new_post.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomSearchBarWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class PostsWidget extends StatefulWidget {
  PostsWidget({Key key}) : super(key: key);
  @override
  _PostsWidgetState createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  TextEditingController searchTextEditingController = new TextEditingController();
  DataSourceGet apiGet = DataSourceGet();
  DataSourceSet apiSet = DataSourceSet();
  List<Post> postsList;

  Future<void> getCurrentUserPostsAPI() => apiGet.getCurrentUserPostsAPI().then((value) => setState(() => this.postsList = value));

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getCurrentUserPostsAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        CustomSearchBarWidget(searchTextEditingController: this.searchTextEditingController),
        SizedBox(height: 8.0),
        CommunChipWidget(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewPosWidget())),
          edgeInsetsGeometry: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
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
        // ListView.separated(
        //   separatorBuilder: (context, index) => SizedBox(height: 8.0),
        //   padding: EdgeInsets.zero,
        //   shrinkWrap: true,
        //   itemCount: this.postsList.length,
        //   itemBuilder: (context, index) {
        //     return PostItemWidget(post:this.postsList.elementAt(index));
        //   },
        // ),
      ],
    );
  }
}

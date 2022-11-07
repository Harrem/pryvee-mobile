import 'package:pryvee/src/widgets/shared_inside/CustomSearchBarWidget.dart';
import 'package:pryvee/src/widgets/LivePostItemWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TextEditingController searchTextEditingController = TextEditingController();

  DataSourceGet apiGet = DataSourceGet();
  bool _firstSearch = true;
  String _query = "";

  _HomeWidgetState() {
    this.searchTextEditingController.addListener(() {
      if (this.searchTextEditingController.text.isEmpty) {
        setState(() {
          this._firstSearch = true;
          this._query = "";
        });
      } else {
        setState(() {
          this._firstSearch = false;
          this._query = this.searchTextEditingController.text;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        CustomSearchBarWidget(
          searchTextEditingController: this.searchTextEditingController,
        ),
        SizedBox(height: 12.0),
        Row(
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
        ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 8.0),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return LivePostItemWidget();
          },
        ),
        SizedBox(height: 12.0),
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
          itemCount: 7,
          itemBuilder: (context, index) {
            return LivePostItemWidget();
          },
        ),
      ],
    );
  }

  Widget _performSearch() {
    return SizedBox();
  }
}

import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/models/help.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/widgets/UserAvatarButtonWidget.dart';

class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              UiIcons.return_icon,
              color: Theme.of(context).hintColor,
              size: 20.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Help and support',
            style: Theme.of(context).textTheme.headline4,
          ),
          actions: <Widget>[UserAvatarButtonWidget()],
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: APP_COLOR,
            isScrollable: true,
            tabs: [
              Tab(text: 'FAQ'),
              Tab(text: 'Terms & Conditions'),
              Tab(text: 'Shipping & Returns'),
              Tab(text: 'Privacy Policy'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FAQWidget(),
            TermsAndConditionsWidget(),
            ShippingAndReturnsWidget(),
            PrivacyPolicyWidget(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FAQWidget extends StatelessWidget {
  FAQModelList faqModelList = FAQModelList();

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.help,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Faq',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SizedBox(height: 8.0),
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: this.faqModelList.list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) {
              return SizedBox(height: 8.0);
            },
            itemBuilder: (context, index) {
              FAQModel faqModel = this.faqModelList.list.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: APP_COLOR,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      faqModel.title,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
                    child: Text(
                      faqModel.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      );
}

// ignore: must_be_immutable
class TermsAndConditionsWidget extends StatelessWidget {
  TermsAndConditionsModelList termsAndConditionsModelList = TermsAndConditionsModelList();

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.help,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Terms & Conditions',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SizedBox(height: 8.0),
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: this.termsAndConditionsModelList.list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) {
              return SizedBox(height: 8.0);
            },
            itemBuilder: (context, index) {
              TermsAndConditionsModel termsAndConditionsModel = this.termsAndConditionsModelList.list.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: APP_COLOR,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      termsAndConditionsModel.title,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
                    child: Text(
                      termsAndConditionsModel.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      );
}

// ignore: must_be_immutable
class ShippingAndReturnsWidget extends StatelessWidget {
  ShippingAndReturnsList shippingAndReturnsList = ShippingAndReturnsList();

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.help,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Shipping and returns',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SizedBox(height: 8.0),
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: this.shippingAndReturnsList.list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) {
              return SizedBox(height: 8.0);
            },
            itemBuilder: (context, index) {
              ShippingAndReturns shippingAndReturns = this.shippingAndReturnsList.list.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: APP_COLOR,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      shippingAndReturns.title,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
                    child: Text(
                      shippingAndReturns.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      );
}

// ignore: must_be_immutable
class PrivacyPolicyWidget extends StatelessWidget {
  PrivacyPolicyList privacyPolicyList = PrivacyPolicyList();

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.help,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Privacy policy',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SizedBox(height: 8.0),
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: this.privacyPolicyList.list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) {
              return SizedBox(height: 8.0);
            },
            itemBuilder: (context, index) {
              PrivacyPolicy privacyPolicy = this.privacyPolicyList.list.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: APP_COLOR,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      privacyPolicy.title,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
                    child: Text(
                      privacyPolicy.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      );
}

import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/providers_utils/session_notifier.dart';
import 'package:pryvee/src/screens/user_inside/user_tabs.dart';
import 'package:pryvee/config/app_config.dart' as config;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/models/on_boarding.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class OnBoardingWidget extends StatefulWidget {
  OnBoardingWidget({Key key, @required this.sessionNotifier}) : super(key: key);
  SessionNotifier sessionNotifier;
  @override
  _OnBoardingWidget createState() => _OnBoardingWidget();
}

class _OnBoardingWidget extends State<OnBoardingWidget> {
  OnBoardingList _onBoardingList = OnBoardingList();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return (widget.sessionNotifier.getLocalUserId().isNotEmpty)
        ? UserTabsWidget(currentTab: 0)
        : Scaffold(
            backgroundColor: APP_COLOR,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 150.0,
                      child: CommunTextButtonWidget(
                        onPressed: () => Navigator.of(context).pushNamed('/SignIn'),
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyText1.merge(
                                TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        ),
                        color: Colors.transparent,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: this._onBoardingList.list.length,
                    options: CarouselOptions(
                      onPageChanged: (int index, CarouselPageChangedReason changedReason) => setState(() => this._current = index),
                      viewportFraction: 1.0,
                      height: MediaQuery.of(context).size.height / 1.6,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                      OnBoarding boarding = this._onBoardingList.list.elementAt(itemIndex);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              boarding.image,
                              width: MediaQuery.of(context).size.height / 3.0,
                            ),
                          ),
                          Container(
                            width: config.App(context).appWidth(70.0),
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              boarding.description,
                              style: Theme.of(context).textTheme.headline4.merge(
                                    TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _onBoardingList.list.map((OnBoarding boarding) {
                        return Container(
                          width: 25.0,
                          height: 3.0,
                          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            color: _current == _onBoardingList.list.indexOf(boarding) ? Colors.white : Colors.white.withOpacity(0.2),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: CommunTextButtonWidget(
                      onPressed: () => Navigator.of(context).pushNamed('/SignUp'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Sign up',
                            style: Theme.of(context).textTheme.headline6.merge(
                                  TextStyle(
                                    color: APP_COLOR,
                                  ),
                                ),
                          ),
                          SizedBox(width: 6.0),
                          Icon(
                            Icons.arrow_forward,
                            size: 20.0,
                            color: APP_COLOR,
                          ),
                        ],
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

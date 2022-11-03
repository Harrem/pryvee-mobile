import 'package:pryvee/src/widgets/shared_inside/CustomCircularProgressIndicatorWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditEmailWidget extends StatefulWidget {
  EditEmailWidget({Key key, @required this.user, @required this.refreshTheView})
      : super(key: key);
  UserData user;
  ValueChanged<UserData> refreshTheView;

  @override
  _EditEmailWidget createState() => _EditEmailWidget();
}

class _EditEmailWidget extends State<EditEmailWidget> {
  TextEditingController checkEmailController = TextEditingController();
  DataSourceSet apiSet = DataSourceSet();
  String checkEmail = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      // this.checkEmailController.text = widget.user.email;
      // this.checkEmail = widget.user.email;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Edit email address',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shrinkWrap: true,
        primary: false,
        children: [
          Center(
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(100.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    //  widget.user.picture,
                    'https://www.shareicon.net/data/512x512/2017/01/06/868320_people_512x512.png',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Email address',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.transparent,
            ),
            height: 44.0,
            child: TextField(
              cursorColor: Theme.of(context).colorScheme.secondary,
              controller: this.checkEmailController,
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: (String value) =>
                  setState(() => this.checkEmail = value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 6.0),
                hintText: 'Email address',
                hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                    TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4))),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          (this.isLoading)
              ? CustomCircularProgressIndicatorWidget(
                  alignmentGeometry: Alignment.center,
                  edgeInsetsGeometry: EdgeInsets.all(14.0),
                )
              : CommunTextButtonWidget(
                  onPressed:
                      // (this.checkEmail.isEmpty || this.checkEmail == widget.user.email)
                      //     ? null
                      //     :
                      () {
                    // if (isValidEmail(this.checkEmail) == false)
                    //   showToast(context, "Please enter a valid email address.");
                    // else {
                    //   setState(() => this.isLoading = !this.isLoading);
                    //   apiSet.editUser(this.checkEmail, widget.user.firstName, widget.user.lastName, widget.user.maritalStatus, widget.user.gender, widget.user.picture).then((value) {
                    //     setState(() => this.isLoading = !this.isLoading);
                    //     if (value != null) {
                    //       setState(() => widget.user = value);
                    //       widget.refreshTheView(value);
                    //       Navigator.of(context).pop();
                    //     } else
                    //       showToast(context, "An error occurred, please try again later.");
                    //   }).catchError((onError) => setState(() => this.isLoading = !this.isLoading));
                    // }
                  },
                  color: APP_COLOR,
                  shape: StadiumBorder(),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

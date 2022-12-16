import 'package:provider/provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomCircularProgressIndicatorWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditPasswordWidget extends StatefulWidget {
  EditPasswordWidget({Key key}) : super(key: key);

  @override
  _EditPasswordWidget createState() => _EditPasswordWidget();
}

class _EditPasswordWidget extends State<EditPasswordWidget> {
  DataSourceSet apiSet = DataSourceSet();

  bool _showSecondPassword = false;
  String checkSecondPassword = '';
  bool _showOldPassword = false;
  String checkOldPassword = '';
  bool _showPassword = false;
  String checkPassword = '';
  bool isLoading = false;

  bool hasErrors() => this.checkOldPassword.isEmpty ||
          this.checkPassword.isEmpty ||
          this.checkSecondPassword.isEmpty ||
          this.checkPassword != this.checkSecondPassword
      ? true
      : false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
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
          'Edit password',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.transparent,
              ),
              height: 44.0,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) =>
                    setState(() => this.checkOldPassword = value),
                obscureText: !this._showOldPassword,
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Old password',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  suffixIcon: IconButton(
                    splashRadius: 25.0,
                    onPressed: () => setState(
                        () => this._showOldPassword = !this._showOldPassword),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                    icon: Icon(
                        this._showOldPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 14.0),
                  ),
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.transparent,
              ),
              height: 44.0,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) =>
                    setState(() => this.checkPassword = value),
                obscureText: !this._showPassword,
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'New password',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  suffixIcon: IconButton(
                    splashRadius: 25.0,
                    onPressed: () => setState(
                        () => this._showPassword = !this._showPassword),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                    icon: Icon(
                        this._showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 14.0),
                  ),
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.transparent,
              ),
              height: 44.0,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) =>
                    setState(() => this.checkSecondPassword = value),
                obscureText: !this._showSecondPassword,
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Confirm new password',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  suffixIcon: IconButton(
                    splashRadius: 25.0,
                    onPressed: () => setState(() =>
                        this._showSecondPassword = !this._showSecondPassword),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                    icon: Icon(
                        this._showSecondPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 14.0),
                  ),
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
                    onPressed: hasErrors()
                        ? null
                        : () {
                            setState(() => this.isLoading = !this.isLoading);
                            user
                                .updatePassword(
                                    this.checkOldPassword, this.checkPassword)
                                .then((value) {
                              setState(() => this.isLoading = !this.isLoading);
                              showToast(
                                  context, "Password updated successfully");
                              Navigator.of(context).pop();
                            }).catchError((onError) {
                              showToast(context, "$onError");
                              setState(() => this.isLoading = !this.isLoading);
                            });
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
      ),
    );
  }
}

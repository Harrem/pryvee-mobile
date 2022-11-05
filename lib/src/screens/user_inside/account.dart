import 'package:provider/provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/user_inside/edit_operations/edit_password.dart';
import 'package:pryvee/src/screens/user_inside/edit_operations/edit_account.dart';
import 'package:pryvee/src/screens/user_inside/edit_operations/edit_email.dart';
import 'package:pryvee/src/widgets/modal_bottom_sheet/add_new_photo_sheet.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomInkWell.dart';
import 'package:pryvee/src/screens/user_inside/help.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:share_extend/share_extend.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable
import 'dart:io';

class AccountWidget extends StatefulWidget {
  AccountWidget({Key key}) : super(key: key);
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  DataSourceGet apiGet = DataSourceGet();
  DataSourceSet apiSet = DataSourceSet();
  bool isLoading1 = false;
  bool isLoading2 = false;

  void updateProfilePictureRefreshTheView(File file) {
    // setState(() => this.isLoading1 = !this.isLoading1);
    // apiSet
    //     .uploadImageToCloudinary(file, "user/profile", 'USER_ID_PROFILE_${widget.user.userId}')
    //     .then((CloudinaryResponse cloudinaryResponse) =>
    //         apiSet.editUser(widget.user.email, widget.user.firstName, widget.user.lastName, widget.user.maritalStatus, widget.user.gender, '$CLOUDINARY_IMAGE_BASE_URL/${cloudinaryResponse.public_id}').then((User user) {
    //           setState(() => this.isLoading1 = !this.isLoading1);
    //           if (user is User) {
    //             setState(() => widget.user = user);
    //             widget.refreshTheView(user);
    //           } else
    //             showToast(context, "An error occurred, please try again later.");
    //         }).catchError((onError) => setState(() => this.isLoading1 = !this.isLoading1)))
    //     .catchError((onError) => setState(() => this.isLoading1 = !this.isLoading1));
  }

  // void deleteProfilePictureRefreshTheView(bool value) =>
  //     apiSet.editUser(widget.user.email, widget.user.firstName, widget.user.lastName, widget.user.maritalStatus, widget.user.gender, '$CLOUDINARY_IMAGE_BASE_URL/user/default-profile').then((value) {
  //       if (value is User) {
  //         setState(() => widget.user = value);
  //         widget.refreshTheView(value);
  //       } else
  //         showToast(context, "An error occurred, please try again later.");
  //     });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).userData;
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(2.0),
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(color: APP_COLOR, width: 1.0),
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.transparent,
                ),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.picture,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          '${user.firstName} ${user.lastName}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2.merge(
                TextStyle(
                  fontSize: 18.0,
                ),
              ),
        ),
        Text(
          user.email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption.merge(
                TextStyle(
                  fontSize: 12.0,
                ),
              ),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '234',
                  style: Theme.of(context).textTheme.headline2.merge(
                        TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                  children: [
                    TextSpan(
                      text: '\nPosts',
                      style: Theme.of(context).textTheme.bodyText1.merge(
                            TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '434',
                  style: Theme.of(context).textTheme.headline2.merge(
                        TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                  children: [
                    TextSpan(
                      text: '\nContacts',
                      style: Theme.of(context).textTheme.bodyText1.merge(
                            TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '5',
                  style: Theme.of(context).textTheme.headline2.merge(
                        TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                  children: [
                    TextSpan(
                      text: '\nLivePosts',
                      style: Theme.of(context).textTheme.bodyText1.merge(
                            TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        CommunTextButtonWidget(
          color: APP_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Share my profile',
            style: Theme.of(context).textTheme.bodyText1.merge(
                  TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
        ),
        SizedBox(height: 10.0),
        CommunChipWidget(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditAccountWidget())),
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.user_1,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditEmailWidget())),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.envelope,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Email address',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPasswordWidget())),
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.key,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.settings,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () =>
              Navigator.of(context).pushNamed('/UserTabs', arguments: 1),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.layers,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'My post',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () =>
              Navigator.of(context).pushNamed('/UserTabs', arguments: 1),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.shield,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Trusted contacts',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () =>
              Navigator.of(context).pushNamed('/UserTabs', arguments: 1),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.credit_card,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Payments method',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HelpWidget())),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.information,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Faq',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () => ShareExtend.share(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
            "text",
            subject: "Share Pryvee with your friends !",
          ),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.share,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Share with friends',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () {},
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.chat,
                size: 16.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Review Pryvee',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.grey.withOpacity(0.8),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        CommunChipWidget(
          color: Theme.of(context).focusColor.withOpacity(0.4),
          borderRadiusGeometry: BorderRadius.circular(100.0),
          edgeInsetsGeometry: EdgeInsets.all(16.0),
          onTap: () => pryveeSignOut(context),
          child: Row(
            children: <Widget>[
              Icon(
                UiIcons.flag,
                size: 16.0,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Sign out',
                  style: Theme.of(context).textTheme.bodyText1.merge(
                        TextStyle(
                          color: Colors.red,
                        ),
                      ),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.chevron_right_rounded,
                size: 16.0,
                color: Colors.red.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

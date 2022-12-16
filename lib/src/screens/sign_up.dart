import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/user_inside/user_tabs.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomCircularProgressIndicatorWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/SocialMediaWidget.dart';
import 'package:pryvee/src/providers_utils/session_notifier.dart';
import 'package:pryvee/src/providers_utils/theme_notifier.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/utils/theme_utility.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidget createState() => _SignUpWidget();
}

class _SignUpWidget extends State<SignUpWidget> {
  TextEditingController checkFirstNameController = TextEditingController();
  TextEditingController checkPassword1Controller = TextEditingController();
  TextEditingController checkPassword2Controller = TextEditingController();
  TextEditingController checkLastNameController = TextEditingController();
  TextEditingController checkEmailController = TextEditingController();
  DataSourceSet apiSet = DataSourceSet();
  bool _showPassword = false;
  String checkFirstName = '';
  String checkPassword1 = '';
  String checkPassword2 = '';
  String checkLastName = '';
  String checkEmail = '';
  bool isLoading = false;

  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: APP_COLOR,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    margin: EdgeInsets.all(60.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30.0),
                    margin: EdgeInsets.only(
                        top: 100.0, left: 20.0, right: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text('Sign Up',
                            style: Theme.of(context).textTheme.headline3),
                        SizedBox(height: 20),
                        TextField(
                          controller: this.checkEmailController,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String value) =>
                              setState(() => this.checkEmail = value),
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              UiIcons.envelope,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: this.checkFirstNameController,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) =>
                              setState(() => this.checkFirstName = value),
                          decoration: InputDecoration(
                            hintText: 'Firstname',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              UiIcons.user,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: this.checkLastNameController,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) =>
                              setState(() => this.checkLastName = value),
                          decoration: InputDecoration(
                            hintText: 'Lastname',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              UiIcons.user,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          onChanged: (String value) =>
                              setState(() => this.checkPassword1 = value),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          controller: this.checkPassword1Controller,
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1.merge(
                                      TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              size: 20.0,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 24.0,
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.4),
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          onChanged: (String value) =>
                              setState(() => this.checkPassword2 = value),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          controller: this.checkPassword2Controller,
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1.merge(
                                      TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              size: 20.0,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 24.0,
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.4),
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        this.isLoading
                            ? CustomCircularProgressIndicatorWidget(
                                alignmentGeometry: Alignment.center,
                                edgeInsetsGeometry: EdgeInsets.all(14.0),
                              )
                            : CommunTextButtonWidget(
                                color: APP_COLOR,
                                shape: StadiumBorder(),
                                onPressed: (this.checkEmail.trim().isEmpty ||
                                        this.checkFirstName.isEmpty ||
                                        this.checkLastName.isEmpty ||
                                        this.checkPassword1.isEmpty)
                                    ? null
                                    : () {
                                        if (isValidEmail(
                                                this.checkEmail.trim()) ==
                                            false)
                                          showToast(context,
                                              "Please enter a valid email address.");
                                        else if (this.checkPassword1 !=
                                            this.checkPassword2)
                                          showToast(context,
                                              "Password confirmation and Password must match.");
                                        else {
                                          setState(() =>
                                              this.isLoading = !this.isLoading);
                                          apiSet
                                              .registerAPI(
                                                  this.checkEmail.trim(),
                                                  this.checkFirstName,
                                                  this.checkLastName,
                                                  this.checkPassword1)
                                              .then(
                                            (value) async {
                                              this.isLoading = !this.isLoading;
                                              setState(() {});
                                              if (value == null)
                                                showToast(context,
                                                    "The email address is already taken.");
                                              else {
                                                addLocalThemeToSP(
                                                    getStringThemeData(
                                                        lightTheme));
                                                addLocalLocaleLanguageToSP(
                                                    "en_US");
                                                addLocalUserIdToSP(value.uid);
                                                addLocalEmailToSP(value.email);
                                                this.isLoading =
                                                    !this.isLoading;
                                                await userProvider
                                                    .initUserData();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Register()));

                                                // Navigator.of(context)
                                                //     .pushNamedAndRemoveUntil(
                                                //         '/UserTabs',
                                                //         (Route<dynamic>
                                                //                 route) =>
                                                //             false,
                                                //         arguments: 0);
                                              }
                                            },
                                          ).catchError(
                                            (onError) => setState(
                                              () {
                                                debugPrint("$onError");
                                                showToast(
                                                    context, onError.toString(),
                                                    seconds: 3);
                                                this.isLoading =
                                                    !this.isLoading;
                                              },
                                            ),
                                          );
                                        }
                                      },
                                child: Text(
                                  'Sign up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .merge(
                                        TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                ),
                              ),
                        SizedBox(height: 30),
                        Text(
                          'Or using social media',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 20),
                        SocialMediaWidget()
                      ],
                    ),
                  ),
                ],
              ),
              CommunTextButtonWidget(
                color: Colors.transparent,
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SignIn');
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                            color: Colors.white,
                          ),
                        ),
                    children: [
                      TextSpan(text: 'Already have an account ?'),
                      TextSpan(
                          text: ' Sign In',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:pryvee/src/providers_utils/user_data_provider.dart';
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

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidget createState() => _SignInWidget();
}

class _SignInWidget extends State<SignInWidget> {
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController checkEmailController = TextEditingController();
  DataSourceSet apiSet = DataSourceSet();
  bool _showPassword = false;
  String checkPassword = '';
  String checkEmail = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (this.mounted) {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_COLOR,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
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
                        Text('Sign In',
                            style: Theme.of(context).textTheme.headline3),
                        SizedBox(height: 20.0),
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
                        SizedBox(height: 20.0),
                        TextField(
                          controller: this.checkPasswordController,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          onChanged: (String value) =>
                              setState(() => this.checkPassword = value),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                        SizedBox(height: 20.0),
                        CommunTextButtonWidget(
                          color: Colors.transparent,
                          shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.pushNamed(context, '/ForgotPassword');
                          },
                          child: Text(
                            'Forgot your password ?',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        this.isLoading
                            ? CustomCircularProgressIndicatorWidget(
                                alignmentGeometry: Alignment.center,
                                edgeInsetsGeometry: EdgeInsets.all(14.0),
                              )
                            : CommunTextButtonWidget(
                                color: APP_COLOR,
                                shape: StadiumBorder(),
                                onPressed: (this.checkEmail.trim().isEmpty ||
                                        this.checkPassword.isEmpty)
                                    ? null
                                    : () {
                                        setState(() =>
                                            this.isLoading = !this.isLoading);
                                        apiSet
                                            .loginAPI(this.checkEmail.trim(),
                                                this.checkPassword)
                                            .then((value) {
                                          this.isLoading = !this.isLoading;
                                          setState(() {});
                                          if (value == null)
                                            showToast(context,
                                                "The email address or password is incorrect.");
                                          else {
                                            Provider.of<SessionNotifier>(
                                                    context,
                                                    listen: false)
                                                .setLocalUserId(value.uid);
                                            Provider.of<ThemeNotifier>(context,
                                                    listen: false)
                                                .setLocalTheme(lightTheme);
                                            addLocalThemeToSP(
                                                getStringThemeData(lightTheme));
                                            addLocalLocaleLanguageToSP("en_US");
                                            addLocalUserIdToSP(value.uid);
                                            addLocalEmailToSP(value.email);
                                            this.isLoading = !this.isLoading;
                                            setState(() {});

                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/UserTabs',
                                                    (Route<dynamic> route) =>
                                                        false,
                                                    arguments: 0);
                                          }
                                        }).catchError((onError) => setState(() {
                                                  showToast(context, onError,
                                                      seconds: 3);

                                                  this.isLoading =
                                                      !this.isLoading;
                                                }));
                                      },
                                child: Text(
                                  'Login',
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
                        SizedBox(height: 20.0),
                        Text(
                          'Or using social media',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 20.0),
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
                  Navigator.of(context).pushNamed('/SignUp');
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                    children: [
                      TextSpan(text: 'Don\'t have an account ?'),
                      TextSpan(
                          text: ' Sign Up',
                          style: TextStyle(fontWeight: FontWeight.w700)),
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

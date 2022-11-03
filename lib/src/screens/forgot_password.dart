import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomCircularProgressIndicatorWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/SocialMediaWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatefulWidget {
  @override
  _ForgotPasswordWidget createState() => _ForgotPasswordWidget();
}

class _ForgotPasswordWidget extends State<ForgotPasswordWidget> {
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController checkEmailController = TextEditingController();
  DataSourceSet apiSet = DataSourceSet();
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
          ),
        ),
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
                        Text('Reset Password',
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
                        SizedBox(height: 10.0),
                        this.isLoading
                            ? CustomCircularProgressIndicatorWidget(
                                alignmentGeometry: Alignment.center,
                                edgeInsetsGeometry: EdgeInsets.all(14.0),
                              )
                            : CommunTextButtonWidget(
                                color: APP_COLOR,
                                shape: StadiumBorder(),
                                onPressed: (this.checkEmail.trim().isEmpty)
                                    ? null
                                    : () async {
                                        setState(() =>
                                            this.isLoading = !this.isLoading);
                                        await apiSet
                                            .forgotPasswordAPI(
                                                this.checkEmail.trim())
                                            .then((value) {
                                          this.isLoading = !this.isLoading;
                                          setState(() {});
                                          showToast(context,
                                              "Reset Password Link Sent",
                                              seconds: 3);
                                        }).catchError((error) {
                                          showToast(context, error.toString(),
                                              seconds: 3);
                                          this.isLoading = !this.isLoading;
                                        });

                                        // catchError((onError) => setState(() {
                                        //           showToast(context, onError);
                                        //           this.isLoading =
                                        //               !this.isLoading;
                                        //         }));
                                      },
                                child: Text(
                                  'Reset',
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

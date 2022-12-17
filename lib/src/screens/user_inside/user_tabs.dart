import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/src/providers_utils/conversation_provider.dart';
import 'package:pryvee/src/screens/user_inside/conversation_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/screens/user_inside/account.dart';
import 'package:pryvee/src/models/commun_select_model.dart';
import 'package:pryvee/src/screens/user_inside/posts.dart';
import 'package:pryvee/src/screens/user_inside/home.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';

import '../../providers_utils/user_data_provider.dart';

// ignore: must_be_immutable
class UserTabsWidget extends StatefulWidget {
  UserTabsWidget({Key key}) : super(key: key);

  @override
  _UserTabsWidget createState() => _UserTabsWidget();
}

class _UserTabsWidget extends State<UserTabsWidget>
    with TickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  TabController tabController;
  int currentTab = 0;
  bool isLoading = true;

  List<CommunSelectModel> communSelectModelList = [
    CommunSelectModel("Home", true),
    CommunSelectModel("Post", true),
    CommunSelectModel("Inbox", true),
    CommunSelectModel("Profile", true),
  ];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .initUserData()
        .then((user) {
      final p = Provider.of<ConversationProvider>(context, listen: false);
      p.initConv();
      if (this.mounted)
        setState(() {
          isLoading = false;
        });
    });

    super.initState();
    tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            splashRadius: 24.0,
            icon: Icon(
              Icons.sort,
              size: 20.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            this.communSelectModelList.elementAt(currentTab).name,
            style: Theme.of(context).textTheme.headline4.merge(
                  TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
          ),
          actions: <Widget>[
            isLoading
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(DEFAULT_USER_PICTURE)),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userProvider.userData.picture)),
                  )
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomeWidget(),
            PostsWidget(),
            ConversationScreen(),
            AccountWidget(),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => Register()));
        //   },
        //   child: Icon(Icons.phone),
        // ),
        bottomNavigationBar: SafeArea(
          child: CurvedNavigationBar(
            buttonBackgroundColor: APP_COLOR,
            backgroundColor: Colors.transparent,
            onTap: (int index) {
              tabController.index = index;
              debugPrint((tabController == null).toString());
            },
            index: currentTab,
            animationDuration: Duration(milliseconds: 400),
            animationCurve: Curves.easeOut,
            color: APP_COLOR,
            height: 50.0,
            items: <Widget>[
              Icon(
                UiIcons.home,
                size: 16.0,
                color: Colors.white,
              ),
              Icon(
                UiIcons.layers,
                size: 16.0,
                color: Colors.white,
              ),
              Icon(
                UiIcons.message_1,
                size: 16.0,
                color: Colors.white,
              ),
              Icon(
                UiIcons.user_1,
                size: 16.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var phoneNoController = TextEditingController();
  var hasError = true;
  Country country = CountryService().findByName('United States');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff7f6fb),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: GestureDetector(
                //     onTap: () => Navigator.pop(context),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 32,
                //       color: Colors.black54,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 251, 231, 231),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'img/illustration-2.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your phone number. we'll send you a verification code so we know you're real",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: phoneNoController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              child: country != null
                                  ? Text(country.flagEmoji)
                                  : Text("🏳"),
                              onTap: () {
                                country;
                                showCountryPicker(
                                    showPhoneCode: true,
                                    context: context,
                                    onSelect: (c) {
                                      setState(() {
                                        country = c;
                                      });
                                    });
                              },
                            ),
                          ),
                          suffixIcon: Icon(
                            hasError ? Icons.close_rounded : Icons.check_circle,
                            color: hasError ? Colors.red : Colors.green,
                            size: 32,
                          ),
                        ),
                        onChanged: ((value) {
                          if (value.length != 10) {
                            setState(() {
                              hasError = true;
                            });
                          } else {
                            setState(() {
                              hasError = false;
                            });
                          }
                        }),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (phoneNoController.value.text.isNotEmpty) {
                              String phoneNo =
                                  "+${country.phoneCode}${phoneNoController.text.trim()}";
                              debugPrint("PhoneNo: " + phoneNo);
                              // await verifyPhoenNo(
                              //         "+964${phoneNoController.text.trim()}")
                              //     .then((value) => debugPrint("Code Sent"));

                              await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: phoneNo,
                                  timeout: Duration(seconds: 100),
                                  verificationCompleted:
                                      (phoneCredential) async {
                                    await FirebaseAuth.instance.currentUser
                                        .linkWithCredential(phoneCredential)
                                        .then((value) => debugPrint(
                                            "Phone number linked to account"))
                                        .catchError((e) {
                                      showToast(context, "$e");
                                      debugPrint(
                                          "linking failed with error: $e");
                                    });
                                    debugPrint("Verification Completed");
                                  },
                                  verificationFailed: (e) {
                                    debugPrint("failed: " + e.code);
                                  },
                                  codeSent: (verificationId, resendToken) {
                                    debugPrint("resendToken is: " +
                                        resendToken.toString());

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Otp(vid: verificationId),
                                      ),
                                    );
                                  },
                                  codeAutoRetrievalTimeout: (v) {
                                    debugPrint("Code Timeout!");
                                  });
                              // );
                            } else {
                              showToast(context, "Wrong Phone Number!");
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.purple),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<PhoneAuthProvider> verifyPhoenNo(String phoneNo) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 90),
        verificationCompleted: (val) {
          debugPrint("Verification Completed");
          return val;
        },
        verificationFailed: (e) {
          debugPrint(e.code);
        },
        codeSent: (str, c) {
          debugPrint(str);
          debugPrint("Code is: " + c.toString());
        },
        codeAutoRetrievalTimeout: (v) {
          debugPrint("Code Timeout!");
        });
    return null;
  }
}

class Otp extends StatefulWidget {
  const Otp({Key key, @required this.vid}) : super(key: key);
  final String vid;
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String smsCode;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 251, 246, 246),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.topRight,
              //   child: GestureDetector(
              //     onTap: () => Navigator.pushNamed(context, "/UserTabs"),
              //     child: Text("Skip"),
              //   ),
              // ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'img/illustration-3.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     _textFieldOTP(first: true, last: false, id: 0),
                    //     _textFieldOTP(first: false, last: false, id: 1),
                    //     _textFieldOTP(first: false, last: false, id: 2),
                    //     _textFieldOTP(first: false, last: false, id: 3),
                    //     _textFieldOTP(first: false, last: false, id: 4),
                    //     _textFieldOTP(first: false, last: true, id: 5),
                    //   ],
                    // ),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: "Enter Code",
                      ),
                      onChanged: (value) {
                        smsCode = value;
                      },
                      maxLength: 6,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          PhoneAuthCredential phoneCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: widget.vid, smsCode: smsCode);
                          await FirebaseAuth.instance.currentUser
                              .linkWithCredential(phoneCredential)
                              .then((value) async {
                            if (value.user != null) {
                              debugPrint("Account Linked Successfully");
                              Provider.of<UserProvider>(context, listen: false)
                                  .userData
                                  .phone = value.user.phoneNumber;
                              await Provider.of<UserProvider>(context,
                                      listen: false)
                                  .uploadUserData();
                              Navigator.pushNamed(context, "/UserTabs");
                            }
                          }).onError<FirebaseAuthException>((e, stackTrace) {
                            debugPrint(e.code);
                            if (e.code.toLowerCase() ==
                                "invalid-verification-code") {
                              showToast(context, "Wrong Code Entered!");
                            } else {
                              showToast(context, e.message);
                            }
                          }).catchError((e) {
                            debugPrint("Error: $e");
                          });
                        },
                        // style: ButtonStyle(
                        //   foregroundColor:
                        //       MaterialStateProperty.all<Color>(Colors.white),
                        //   backgroundColor:
                        //       MaterialStateProperty.all<Color>(Colors.purple),
                        //   shape:
                        //       MaterialStateProperty.all<RoundedRectangleBorder>(
                        //     RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(24.0),
                        //     ),
                        //   ),
                        // ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: APP_COLOR,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _textFieldOTP({bool first, last, int id}) {
  //   return Container(
  //     height: 60,
  //     padding: EdgeInsets.all(5),
  //     child: AspectRatio(
  //       aspectRatio: 0.9,
  //       child: TextField(
  //         autofocus: true,
  //         onChanged: (value) {
  //           smsCode[id].replaceRange(0, 0, value);
  //           debugPrint("smsCode is: $smsCode $value");
  //           if (value.length == 1 && last == false) {
  //             FocusScope.of(context).nextFocus();
  //           }
  //           if (value.length == 0 && first == false) {
  //             FocusScope.of(context).previousFocus();
  //           }
  //         },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: InputDecoration(
  //           counter: Offstage(),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: Colors.black12),
  //               borderRadius: BorderRadius.circular(12)),
  //           focusedBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: APP_COLOR),
  //               borderRadius: BorderRadius.circular(12)),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/src/app_delegate_locale.dart/app_localization.dart';
import 'package:pryvee/src/controllers/notification_controller.dart';
import 'package:pryvee/src/providers_utils/auth_provider.dart';
import 'package:pryvee/src/providers_utils/locale_language_notifier.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pryvee/src/providers_utils/post_provider.dart';
import 'package:pryvee/src/providers_utils/session_notifier.dart';
import 'package:pryvee/src/providers_utils/theme_notifier.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/forgot_password.dart';
import 'package:pryvee/src/screens/user_inside/sos.dart';
import 'package:pryvee/src/screens/user_inside/trusted_contacts.dart';
import 'package:pryvee/src/screens/user_inside/user_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/screens/on_boarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pryvee/src/screens/sign_up.dart';
import 'package:pryvee/src/screens/signin.dart';
import 'package:pryvee/src/utils/locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();

  await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'scheduled notifications',
          channelDescription: 'Notification channel for tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: APP_COLOR,
          importance: NotificationImportance.Max,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupkey: 'basic_channel_group',
          channelGroupName: 'basic group',
        )
      ],
      debug: true);

  Rx.forkJoinList([SharedPreferences.getInstance().asStream()])
      .listen((List<dynamic> value) {
    String localLocaleLanguage = value.first.getString('localLocaleLanguage');
    String localUserId = value.first.getString('localUserId');
    String localTheme = value.first.getString('localTheme');
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider<LocaleLanguageNotifier>(
          create: (_) => LocaleLanguageNotifier(
              getLocaleFromString(localLocaleLanguage ?? 'en_US'))),
      ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(getThemeDataFromString(localTheme))),
      ChangeNotifierProvider<SessionNotifier>(
          create: (_) => SessionNotifier(localUserId ?? "")),
    ], child: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  @override
  static final navigatorKey = GlobalKey<NavigatorState>();
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  StreamSubscription<User> _sub;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      addLocalLocationToSP("36.8089092" + "_" + "10.1363789");
    }
    AwesomeNotifications().actionStream.listen((receivedAction) {
      debugPrint(receivedAction.toString() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      if (receivedAction.channelKey == 'basic_channel') {
        NotificationController.onActionReceivedMethod(receivedAction);
      }
    });
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          ChangeNotifierProvider<PostProvider>(
              create: (context) => PostProvider()),
        ],
        child: Consumer2<ThemeNotifier, SessionNotifier>(
          builder: (context, themeNotifier, sessionNotifier, _) =>
              ScreenUtilInit(
            builder: (context, child) => MaterialApp(
              localizationsDelegates: [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              locale:
                  Provider.of<LocaleLanguageNotifier>(context, listen: false)
                      .getLocalLocaleLanguage(),
              supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
              navigatorKey: MyApp.navigatorKey,
              theme: themeNotifier.getLocalTheme(),
              debugShowCheckedModeBanner: false,
              title: 'Pryvee',
              onGenerateRoute: (RouteSettings routeSettings) {
                Object args = routeSettings.arguments;
                switch (routeSettings.name) {
                  case '/':
                    return MaterialPageRoute(
                        builder: (_) => OnBoardingWidget());
                  case '/SignIn':
                    return MaterialPageRoute(builder: (_) => SignInWidget());
                  case '/SignUp':
                    return MaterialPageRoute(builder: (_) => SignUpWidget());
                  case '/ForgotPassword':
                    return MaterialPageRoute(
                        builder: (_) => ForgotPasswordWidget());
                  case '/UserTabs':
                    return MaterialPageRoute(builder: (_) => UserTabsWidget());
                  case '/TrustedContacts':
                    return MaterialPageRoute(builder: (_) => TrustedContacts());
                  case '/notification-page':
                    return MaterialPageRoute(builder: (_) => SOSPage());
                  default:
                    return MaterialPageRoute(
                        builder: (_) => OnBoardingWidget());
                }
              },
            ),
          ),
        ),
      );
}

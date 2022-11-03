
// import 'package:flutter/material.dart';
// import 'package:pryvee/src/screens/sign_up.dart';
// import 'package:pryvee/src/screens/signin.dart';
// import 'package:pryvee/src/screens/user_inside/home.dart';

// class RouteGenerator {
//   static const String home = "./src/screens/user_inside/home.dart";
//   static const String signIn = "./src/screens/signin.dart";
//   static const String signUp = "./src/screens/sign_up.dart";
//   static const String createProfile = "./screens/create_profile.dart";
//   static const String settingPage = "./screens/settings.dart";
//   static const String forgotPassword = "./screens/forgot_password.dart";
//   static const String resetPassword = "./screens/reset_password.dart";
//   static const String searchPage = "./screens/search.dart";
//   static const String messagePage = "./screens/message.dart";
//   static const String loadingPage = "./screens/loading.dart";
//   static const String editProfilePic = "./screens/edit_profile_pic.dart";

//   static const String userTabs = "./";
  

//   RouteGenerator._();

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case home:
//         return MaterialPageRoute(builder: (_) => HomeWidget());
//       case signIn:
//         return MaterialPageRoute(builder: (_) => SignInWidget());
//       case signUp:
//         return MaterialPageRoute(builder: (_) => SignUpWidget());
//       case settingPage:
//         return MaterialPageRoute(builder: (_) => const Settings());
//       case createProfile:
//         return MaterialPageRoute(builder: (_) => const CreateProfile());
//       case forgotPassword:
//         return MaterialPageRoute(builder: (_) => const ForgotPassword());
//       case resetPassword:
//         return MaterialPageRoute(builder: (_) => const ResetPassword());
//       case searchPage:
//         return MaterialPageRoute(builder: (_) => Search());
//       case messagePage:
//         return MaterialPageRoute(builder: (_) => const MessageScreen());
//       case editProfilePic:
//         return MaterialPageRoute(builder: (_) => const EditProfilePicPage());
//       case loadingPage:
//         return MaterialPageRoute(builder: (_) => const Loading());
//       default:
//         return MaterialPageRoute(builder: (_) => const Loading());
//     }
//   }
// }

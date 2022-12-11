import 'dart:convert';

import 'package:http/http.dart';

import '../../data/data_source_const.dart';

class NotificationServices {
  Future<Response> sendNotification(List<String> tokenIdList, String contents,
      String heading, String img) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id":
            kAppId, //kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids":
            tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_launcher",

        "large_icon": "$img",

        "headings": {"en": heading},

        "contents": {"en": contents},

        "buttons": [
          {"id": "1", "text": "Reply", "icon": "ic_menu_share"},
          {"id": "2", "text": "Dismiss", "icon": "ic_menu_send"}
        ]
      }),
    );
  }
}

import 'package:url_launcher/url_launcher.dart';

class ContactOperations {
  static void dail(String number) async {
    var uri = Uri.parse("tel:$number");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static void email(String email) async {
    var uri = Uri.parse(
        "mailto:$email?subject=CRITICAL SITUATION!&body= I need help ASAP!");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static void sms(String phoneNo) async {
    var uri = Uri.parse("sms:$phoneNo");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

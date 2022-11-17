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
}

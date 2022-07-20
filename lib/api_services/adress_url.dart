import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://goo.gl/maps/MHYWNU2efP9Uy2WH9');

launchUrl_() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

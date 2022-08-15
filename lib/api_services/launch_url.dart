import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://goo.gl/maps/MHYWNU2efP9Uy2WH9');
final Uri _waUrl = Uri.parse('https://wa.me/?text=HAI SEMUANYA');
launchLocation() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

launchWhatsapp() async {
  if (!await canLaunchUrl(_waUrl)) {
    await launchUrl(_waUrl);
  } else {
    throw 'Could not launch $_waUrl';
  }
}

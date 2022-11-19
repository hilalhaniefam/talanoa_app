import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://goo.gl/maps/MHYWNU2efP9Uy2WH9');
final Uri _waUrl = Uri.parse('https://wa.me/message/A6G54UUAQ46WG1');
launchLocation() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}

// launchWhatsapp() async {
//   await launchUrl(_waUrl, mode: LaunchMode.externalApplication);
// }
launchWhatsapp() async {
  if (!await canLaunchUrl(_waUrl)) {
    await launchUrl(_waUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $_waUrl';
  }
}

import 'package:flutter/material.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
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
launchWhatsapp({required BuildContext context}) async {
  if (!await canLaunchUrl(_waUrl)) {
    await launchUrl(_waUrl, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackbar("Error while open WhatsApp"));
  }
}

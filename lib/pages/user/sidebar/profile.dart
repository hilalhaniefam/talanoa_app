import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map formValue = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController()
  };

  void updateUser(String name, String phone) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map<String, dynamic> userData =
          jsonDecode(sharedPreferences.getString('userData').toString())
              as Map<String, dynamic>;
      String token = userData['accessToken'];
      Response response = await put(Uri.parse('$ipurl/update-user'), body: {
        'name': name,
        'phone': phone,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      print('Update User:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userData', jsonEncode(data['payload']));
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['status'].toString()));
      } else {
        if (data['message'].isNotEmpty) {
          throw data['message'];
        } else {
          throw data['error'];
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
    }
  }

  Future<String> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    print('getUser:');
    print(userData);
    setState(() {
      formValue['name'].text = userData['name'];
      formValue['email'].text = userData['email'];
      formValue['phone'].text = userData['phone'];
    });
    return userData[{'name', 'email', 'phone'}] ?? 'loading';
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(backButton: _handleBack),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(color: HexColor('#B9C5B2')),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Profile Account',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: HexColor('A7B79F')),
                  child: Column(children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 35, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Full Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )),
                    Form(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        top: 11,
                        left: 20,
                        right: 29,
                      ),
                      child: TextFormField(
                        controller: formValue['name'],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontFamily: 'Josefin Sans', fontSize: 17),
                      ),
                    )),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 14, left: 20),
                          child: Text(
                            'Email Address',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 11,
                        left: 20,
                        right: 29,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: formValue['email'],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontFamily: 'Josefin Sans', fontSize: 17),
                      ),
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 14, left: 20),
                          child: Text(
                            'Phone Number',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 11,
                        left: 20,
                        right: 29,
                      ),
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: formValue['phone'],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                        ),
                        style: const TextStyle(
                            fontFamily: 'Josefin Sans', fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    submitButton(
                        onTap: () {
                          updateUser(
                              formValue['name'].text, formValue['phone'].text);
                        },
                        title: 'Update')
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

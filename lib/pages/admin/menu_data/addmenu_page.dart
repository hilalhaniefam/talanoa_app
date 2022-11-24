import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/admin/get_image.dart';
import 'package:talanoa_app/widgets/admin/menu_button.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/listmenu_catalogue.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? imageFile;
  final String ip = '$ipurl/menu/add';
  final picker = ImagePicker();
  Map formValue = {
    'productName': TextEditingController(),
    'description': TextEditingController(),
    'type': ''
  };
  _handleBack() => Navigator.of(context).pop();

  pickImage() async {
    XFile? pickedFile = (await picker.pickImage(source: ImageSource.gallery));

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Color setTypeButtonColor(type) {
    if (formValue['type'] == type) {
      return Colors.white;
    }
    return Colors.transparent;
  }

  void chooseCategory(type) {
    setState(() {
      formValue = {...formValue, 'type': type};
    });
  }

  void addMenu(String type, String name, String description) async {
    try {
      if (imageFile == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar('Please insert an image!'));
      }
      var fileName = imageFile!.path.split('/').last;
      var formData = FormData.fromMap(
        {
          'type': type,
          'name': name,
          'description': description,
          "imageFile": await MultipartFile.fromFile(
            imageFile!.path,
            filename: fileName,
            contentType: MediaType('image', 'jpg'),
          ),
        },
      );
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var userData =
          jsonDecode(sharedPreferences.getString('userData').toString());
      final token = userData['accessToken'];
      debugPrint(token);
      var dio = Dio();
      Response response = await dio.post(
        ip,
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
            headers: {"Authorization": "Bearer $token"}),
      );
      var responseBody = response.data;
      var data = responseBody;
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['message']));
        setState(() {
          imageFile = null;
          formValue['productName'].clear();
          formValue['description'].clear();
          chooseCategory('');
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['message']));
      }
      print(response.statusCode);
      print(responseBody);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAdmin(backButton: _handleBack, title: 'Add Menu Data'),
      backgroundColor: HexColor('A7B79F'),
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Center(
            child: SingleChildScrollView(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 23, 18, 30),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 11),
                                child: Text(
                                  'Add Photo',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ImgPicker.inputImage(
                              onTap: () {
                                pickImage();
                              },
                              child: imageFile == null
                                  ? const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 35,
                                      ),
                                    )
                                  : Center(
                                      child: Image.file(
                                        imageFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 11),
                                child: Text(
                                  'Add Product Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: formValue['productName'],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0)),
                              ),
                              style: const TextStyle(
                                  fontFamily: 'Josefin Sans', fontSize: 17),
                            )),
                        const SizedBox(
                          height: 26,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 11),
                                child: Text(
                                  'Add Description',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        SizedBox(
                            child: TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: formValue['description'],
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 16, right: 16, top: 12.17, bottom: 12.12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0)),
                          ),
                          style: const TextStyle(
                              fontFamily: 'Josefin Sans', fontSize: 17),
                        )),
                        const SizedBox(
                          height: 26,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 11),
                                child: Text(
                                  'Choose Category',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: categories1
                                .map((category) => Row(
                                      children: [
                                        buildButtonChooseCategory(
                                            backgroundColor: setTypeButtonColor(
                                                category['type']),
                                            title: category['name'].toString(),
                                            onClicked: () {
                                              chooseCategory(category['type']);
                                            }),
                                      ],
                                    ))
                                .toList()),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: categories2
                                .map((category2) => Row(
                                      children: [
                                        buildButtonChooseCategory(
                                            backgroundColor: setTypeButtonColor(
                                                category2['type']),
                                            title: category2['name'].toString(),
                                            onClicked: () {
                                              chooseCategory(category2['type']);
                                            })
                                      ],
                                    ))
                                .toList()),
                        Padding(
                            padding: const EdgeInsets.only(top: 52, bottom: 15),
                            child: submitButton(
                                onTap: () {
                                  final progress = ProgressHUD.of(context);
                                  progress?.show();
                                  Future.delayed(const Duration(seconds: 4),
                                      () {
                                    progress?.dismiss();
                                  });
                                  addMenu(
                                    formValue['type'].toString(),
                                    formValue['productName'].text.toString(),
                                    formValue['description'].text.toString(),
                                  );
                                },
                                title: 'Done')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

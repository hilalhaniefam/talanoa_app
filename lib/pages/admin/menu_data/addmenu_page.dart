import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/admin/get_image.dart';
import 'package:talanoa_app/widgets/admin/menu_button.dart';
import 'package:talanoa_app/pages/admin/menu_data/listmenu_catalogue.dart';
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
    // if (imgFile == null) return;
    // File tmpFile = File(imgFile.path);
    // tmpFile = await tmpFile.copy(tmpFile.path);
    // setState(() {
    // file = File(imgFile!.path);
    // });
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
      debugPrint(imageFile!.path);
      var fileName = imageFile!.path.split('/').last;
      var formData = FormData.fromMap(
        {
          "imageFile": await MultipartFile.fromFile(
            imageFile!.path,
            filename: fileName,
            contentType: MediaType('image', 'jpg'),
          ),
          'type': type,
          'name': name,
          'description': description
        },
      );
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var userData =
          jsonDecode(sharedPreferences.getString('userData').toString());
      final token = userData['accessToken'];
      debugPrint(token);
      var dio = Dio();
      var response = await dio.post(
        ip,
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      var responseBody = response.data;
      print(responseBody);
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: IconButton(
            onPressed: _handleBack,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: HexColor('#B9C5B2'),
        ),
        backgroundColor: HexColor('A7B79F'),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    decoration: BoxDecoration(color: HexColor('#B9C5B2')),
                    child: Text(
                      'Menu Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(5, 5),
                                blurRadius: 15),
                          ],
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 23, 18, 30),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, bottom: 11),
                                child: Text(
                                  'Add Photo',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        ImgPicker.inputImage(
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, bottom: 11),
                                child: Text(
                                  'Add Product Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        SizedBox(
                            width: 330,
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
                                padding:
                                    const EdgeInsets.only(left: 32, bottom: 11),
                                child: Text(
                                  'Add Description',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        SizedBox(
                            width: 330,
                            child: TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: formValue['description'],
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 12.17,
                                    bottom: 12.12),
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
                                padding:
                                    const EdgeInsets.only(left: 32, bottom: 11),
                                child: Text(
                                  'Choose Category',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#343434')),
                                ))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          child: SizedBox(
                            width: 194,
                            height: 44,
                            child: FormHelper.submitButton(
                              "Done",
                              () {
                                addMenu(
                                  formValue['type'].toString(),
                                  formValue['productName'].text.toString(),
                                  formValue['description'].text.toString(),
                                );
                              },
                              btnColor: HexColor("#F1ECE1"),
                              borderColor: Colors.grey,
                              txtColor: Colors.black,
                              borderRadius: 10,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

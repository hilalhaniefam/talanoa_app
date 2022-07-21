import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/menu_catalogue.dart';
import 'package:dotted_border/dotted_border.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  Map formValue = {
    'product': TextEditingController(),
    'description': TextEditingController(),
  };
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          leading: IconButton(
            onPressed: _handleBack,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Title(
              color: Colors.black,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 75, top: 55),
                  child: Text(
                    'Menu Data',
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
              )),
          elevation: 0,
          backgroundColor: HexColor('#B9C5B2'),
        ),
        backgroundColor: HexColor('A7B79F'),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 23, 18, 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 32, bottom: 11),
                        child: Text(
                          'Add Photo',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: HexColor('#343434')),
                        ))),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, bottom: 25),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(69, 68),
                          ),
                          onPressed: () {},
                          child: SizedBox(
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 1,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 35,
                                )),
                          ),
                        ))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 32, bottom: 11),
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
                      controller: formValue['product'],
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
                        padding: EdgeInsets.only(left: 32, bottom: 11),
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
                            left: 16, top: 12.17, bottom: 12.12),
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
                        padding: const EdgeInsets.only(left: 32, bottom: 11),
                        child: Text(
                          'Choose Category',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: HexColor('#343434')),
                        ))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row1),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row2),
                Padding(
                  padding: const EdgeInsets.only(top: 52, bottom: 15),
                  child: SizedBox(
                    width: 194,
                    height: 44,
                    child: FormHelper.submitButton(
                      "Done",
                      () {},
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
        ));
  }
}

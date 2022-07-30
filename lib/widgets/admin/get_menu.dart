import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Widget rowItem({
  required BuildContext context,
  required List list,
}) {
  return ListView(
    children: list.map((data) {
      var imageFile = data['imageUrl'];
      return Dismissible(
        background: deleteItem(),
        key: Key(data['menuId']),
        onDismissed: (direction) {},
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 115,
          child: Card(
            color: HexColor('A7B79F'),
            child: Row(
              children: [
                imageFile == null
                    ? Container(
                        color: HexColor('A7B79F'),
                        width: 180,
                        height: 61,
                      )
                    : Image.network(
                        imageFile,
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 17),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  width: 200,
                  height: 110,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data['name'],
                            style: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(height: 6),
                      Text(
                        data['description'],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget deleteItem() => Container(
      color: Colors.redAccent,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.delete),
        ),
      ),
    );

import 'package:flutter/material.dart';

Column formLogin(
        {required TextEditingController emailCon,
        required Function emailonChanged,
        required String? emailerrorText,
        required TextEditingController passCon,
        required Function passonChanged,
        required String? passerrorText}) =>
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 44,
            right: 43,
          ),
          child: TextFormField(
            controller: emailCon,
            onChanged: (value) {
              emailonChanged;
            },
            decoration: InputDecoration(
              errorText: emailerrorText,
              errorStyle: const TextStyle(
                fontSize: 11,
              ),
              contentPadding:
                  const EdgeInsets.only(left: 16, top: 12.17, bottom: 12.12),
              labelText: 'Email',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.black, width: 2.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            style: const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 16.17,
            left: 44,
            right: 43,
          ),
          child: TextFormField(
            onChanged: (value) {
              passonChanged;
            },
            controller: passCon,
            obscureText: true,
            decoration: InputDecoration(
              errorText: passerrorText,
              errorStyle: const TextStyle(
                fontSize: 11,
              ),
              contentPadding:
                  const EdgeInsets.only(left: 16, top: 12.17, bottom: 12.12),
              labelText: 'Password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.black, width: 2.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            style: const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
          ),
        ),
      ],
    );

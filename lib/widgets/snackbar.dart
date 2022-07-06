import 'package:flutter/material.dart';

/// Snackbar kustom untuk menampilkan pesan jika gagal log in atau lainnya
// ignore: non_constant_identifier_names
SnackBar CustomSnackbar(String message) {
  return SnackBar(
      content:
          Text(message, style: const TextStyle(fontFamily: 'Josefin Sans')));
}

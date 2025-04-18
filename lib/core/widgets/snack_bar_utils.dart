import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String msg}) {
  final snackBar = SnackBar(content: Text(msg));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

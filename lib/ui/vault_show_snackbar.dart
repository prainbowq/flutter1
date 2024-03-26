import 'package:flutter/material.dart';

void vaultShowSnackBar(
  final BuildContext context,
  final String text, {
  final bool isError = false,
}) =>
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(!isError ? text : '錯誤：$text。')));

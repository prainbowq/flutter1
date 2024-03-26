import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VaultCopy extends StatelessWidget {
  const VaultCopy({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Clipboard.setData(ClipboardData(text: text)),
      icon: Icon(Icons.copy),
    );
  }
}

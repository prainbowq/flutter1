import 'package:flutter/material.dart';

class VaultEye extends StatelessWidget {
  const VaultEye({super.key, required this.visible, required this.onChanged});

  final bool visible;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onChanged(!visible),
      icon: Icon(!visible ? Icons.visibility : Icons.visibility_off),
    );
  }
}

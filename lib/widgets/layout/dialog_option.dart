import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_social/utils/utils.dart';

class DialogOption extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DialogOption({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      padding: const EdgeInsets.all(20),
      child: Text(text),
      onPressed: onPressed,
    );
  }
}

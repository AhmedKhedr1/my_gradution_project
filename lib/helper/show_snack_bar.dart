  import 'package:flutter/material.dart';

void Show_Bar_Message(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
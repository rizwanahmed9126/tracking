import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

Future<Widget> simpleAlertBox(context, Text title, Text description,
    Function onPressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          content: description,
          actions: [
            TextButton(onPressed: onPressed,
                child: Text(LocaleKeys.Ok.tr(), style: TextStyle(color: Color(0xFF4A843E)),))
          ],
        );
      });
}

Future<Widget> loadingAlertBox(context, Text title,
    Function onPressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title,
          content:CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF4A843E)),
          ),
        );
      });
}
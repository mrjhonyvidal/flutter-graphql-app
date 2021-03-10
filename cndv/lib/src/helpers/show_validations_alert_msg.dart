import 'dart:io';

import 'package:flutter/material.dart';

showValidationsAlertMsg(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          MaterialButton(
              child: Text('Fechar'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  /// TODO showCupertinoDialog(...) Implement dialog box for iOS.
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> alert(BuildContext context,
      {String title, String body, String okText = 'Aceptar'}) async {
    Completer<void> c = Completer();

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
              title: title != null ? Text(title) : null,
              content: body != null ? Text(body) : null,
              actions: [
                CupertinoDialogAction(
                  child: Text(okText),
                  onPressed: () {
                    Navigator.pop(context);
                    c.complete();
                  },
                )
              ]);
        });

    return c.future;
  }

  static Future<bool> confirm(
    BuildContext context, {
    String title,
    String body,
    String confirmText = 'Aceptar',
    String cancelText = 'Cancelar',
  }) async {
    final Completer<bool> c = Completer();

    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            color:Colors.black26,
            child: CupertinoActionSheet(
              title: title != null
                  ? Text(title,
                      style: TextStyle(color: Colors.black, fontSize: 20))
                  : null,
              message: body != null
                  ? Text(body,
                      style: TextStyle(color: Colors.black87, fontSize: 17))
                  : null,
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      c.complete(true);
                    },
                    child: Text(confirmText,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.w300))),
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    c.complete(false);
                  },
                  child: Text(
                    cancelText,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  )),
            ),
          );
        });

    return c.future;
  }
}

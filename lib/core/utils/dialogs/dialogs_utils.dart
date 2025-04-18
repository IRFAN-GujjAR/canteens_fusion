import 'package:canteens_fusion/core/constants/icons_constants.dart';
import 'package:flutter/material.dart';

final class DialogUtils {
  static Future<void> showMessageDialog(BuildContext context,
      {required String message, String? title}) async {
    Widget? titleWidget;
    if (title != null) {
      titleWidget = Text(title);
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: titleWidget,
            content: Text(
              message,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  static Future<void> showErrorDialog(BuildContext context,
      {required String message}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: SizedBox(
              height: 64,
              width: 64,
              child: Image.asset(
                IconsConstants.warning,
              ),
            ),
            content: Text(
              message,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  static Future<bool> showAlertDialog(BuildContext context,
      {required String message, String proceedButtonTxt = 'Yes'}) async {
    bool yes = false;
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text(proceedButtonTxt),
                onPressed: () {
                  yes = true;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });

    return yes;
  }
}

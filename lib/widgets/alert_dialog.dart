import 'package:flutter/material.dart';

void showGlobalAlertConfirm(
    BuildContext context, String title, String text, Function()? onTap) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      if (onTap != null) {
        onTap();
        Navigator.pop(context);
      }
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

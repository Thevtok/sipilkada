// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String message;

  const AlertDialogWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Gagal", style: Theme.of(context).textTheme.bodyMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(message, style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop(); // Tutup dialog
          },
          child: const Text("Tutup"),
        ),
      ],
    );
  }
}

class SuksesDialogWidget extends StatelessWidget {
  final String text;
  final VoidCallback ontap;

  const SuksesDialogWidget({Key? key, required this.text, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Selamat", style: Theme.of(context).textTheme.bodyMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text, style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ontap();
            // Get.offAll(() => const SplashPage(
            //       isLoggedIn: true,
            //     ));
          },
          child: const Text("Tutup"),
        ),
      ],
    );
  }
}

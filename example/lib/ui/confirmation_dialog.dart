import 'package:flutter/material.dart';

Future<bool?> showWifiDisableConfirmationDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Turn Off Wi-Fi?"),
      icon: const Icon(Icons.wifi),
      content: const Text(
        "You are currently communicating through Wi-Fi. "
        "If you disable Wi-Fi, the connection will be refused and "
        "you won’t be able to access Mac settings.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Close the dialog
            // Add logic to turn off Wi-Fi here
          },
          child: const Text("Turn Off"),
        ),
      ],
    ),
  );
  return null;
}

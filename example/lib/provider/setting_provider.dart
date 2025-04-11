import 'package:example/ui/control_mac_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_settings_flutter/mac_settings_flutter.dart';

import '../utils/alerts.dart';

final settingProvider = ChangeNotifierProvider((ref) {
  SettingNotifier settingNotifier = SettingNotifier();

  return settingNotifier;
});

class SettingNotifier extends ChangeNotifier {
  final ipController =
      TextEditingController(text: '192.168.*.**'); // MacBook IP
  final userController =
      TextEditingController(text: 'alpeshshiyal'); // MacBook username
  final passwordController =
      TextEditingController(text: '****'); // MacBook password

  bool isLoading = false;
  MacSettingFlutter macSettingFlutter = MacSettingFlutter();

  Future<void> connectMac(BuildContext context) async {
    final String macIp = ipController.text;
    final String username = userController.text;
    final String password = passwordController.text;

    isLoading = true;
    notifyListeners();

    macSettingFlutter.onAuthenticated = () {
      Alerts.showInfoSnackBar("Authenticated successfully !");
      Navigator.of(context).pushNamed(ControlMacPage.routeName);
    };
    macSettingFlutter.printTrace = (value) {
      debugPrint("print trace:$value");
      Alerts.showInfoSnackBar("$value");
      isLoading = false;
      notifyListeners();
    };

    //connect to mac
    await macSettingFlutter.connectMac(
        ip: macIp, userName: username, macPassword: password);

    isLoading = false;
    notifyListeners();
  }
}

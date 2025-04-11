import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mac_settings_flutter/mac_settings_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('connect to mac test case', () async {
    final macSettingFlutter = MacSettingFlutter();
    expect(
        await macSettingFlutter.connectMac(
          ip: "192.11.1.1",
          userName: "test",
          macPassword: "123",
        ),
        false);
  });
}

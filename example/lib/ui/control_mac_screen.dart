import 'package:example/provider/setting_provider.dart';
import 'package:example/ui/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlMacPage extends ConsumerStatefulWidget {
  static const routeName = "/control_page";

  const ControlMacPage({super.key});

  @override
  ConsumerState<ControlMacPage> createState() => _ControlMac4State();
}

class _ControlMac4State extends ConsumerState<ControlMacPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggle Mac Settings'),
      ),
      body: Builder(builder: (context) {
        var settingProviderRef = ref.watch(settingProvider);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await settingProviderRef.macSettingFlutter.toggleBluetooth();
                },
                child: const Text('Toggle Bluetooth'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await showWifiDisableConfirmationDialog(context);
                  if (result == true) {
                    await settingProviderRef.macSettingFlutter.toggleWifi();
                  }
                },
                child: const Text('Toggle Wi-Fi'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await settingProviderRef.macSettingFlutter
                      .airDropToEveryone();
                },
                child: const Text('AirDrop Everyone'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // await _toggleAirDrop();
                  await settingProviderRef.macSettingFlutter.airDropOff();
                },
                child: const Text('AirDrop Off'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

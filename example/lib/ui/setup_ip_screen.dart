import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/setting_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_field_widget.dart';

class SetupIpScreen extends ConsumerStatefulWidget {
  static const routeName = "/ip_setup";
  const SetupIpScreen({super.key});

  @override
  ConsumerState<SetupIpScreen> createState() => _SetupIpScreenState();
}

class _SetupIpScreenState extends ConsumerState<SetupIpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect with your Mac"),
      ),
      body: Consumer(builder: (context, _, __) {
        var settingRef = ref.watch(settingProvider);

        return Column(
          children: [
            TextFieldInput(
              controller: settingRef.ipController,
              labelText: 'MacBook IP',
              hintText: 'MacBook IP',
            ),
            TextFieldInput(
                controller: settingRef.userController,
                labelText: 'Username',
                hintText: 'Username'),
            TextFieldInput(
              controller: settingRef.passwordController,
              labelText: 'Password',
              hintText: 'Password',
              isPass: true,
            ),
            CustomButton(
                isLoading: settingRef.isLoading,
                onTap: () {
                  settingRef.connectMac(context);
                },
                title: "Connect")
          ],
        );
      }),
    );
  }
}

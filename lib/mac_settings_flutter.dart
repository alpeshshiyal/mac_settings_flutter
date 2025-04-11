library mac_settings_flutter;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssh2/ssh2.dart';

import 'constants/shortcuts.dart';

class MacSettingFlutter {
  SSHClient? ssh;
  void Function(String)? onUserAuthBannerMessage;
  void Function()? onAuthenticated;
  void Function(String?)? printTrace;
  String macIp = "";
  String username = "";
  String password = "";

  Future<bool?> connectMac({
    required String ip,
    required String userName,
    required String macPassword,
    int? port = 22,
  }) async {
    macIp = ip;
    username = userName; // Replace with your Mac username
    password = macPassword;

    String result = '';
    var client = SSHClient(
      host: macIp,
      port: 22,
      username: userName,
      passwordOrKey: password,
    );
    try {
      result = await client.connect() ?? 'Null result';
      if (result == "session_connected") {
        result = await client.execute("ps") ?? 'Null result';
      }
      await client.disconnect();
      if (onAuthenticated != null) {
        onAuthenticated!();
      }
      return true;
    } on PlatformException catch (e) {
      String errorMessage = 'Error: ${e.code}\nError Message: ${e.message}';

      result = errorMessage;
      if (printTrace != null) {
        printTrace!(e.message);
      }
      debugPrint("shh error: $errorMessage");
      return false;
    }

    // _result = result;
  }

  Future toggleBluetooth() async {
    await _runShortCuts(ShortcutsConst.toggleBluetooth);
  }

  Future toggleWifi() async {
    await _runShortCuts(ShortcutsConst.toggleWifi);
  }

  Future airDropToEveryone() async {
    await _runShortCuts(ShortcutsConst.airdropEveryone);
  }

  Future airDropOff() async {
    await _runShortCuts(ShortcutsConst.airdropOff);
  }

  Future<void> _runShortCuts(String shortcut) async {
    await _executeAppleScriptViaSSH("""
    tell application "Shortcuts Events"
	    run shortcut "$shortcut"
    end tell
    """);
  }

  // Helper method to execute AppleScript via SSH
  Future<void> _executeAppleScriptViaSSH(String script) async {
    String result = '';
    var client = SSHClient(
      host: macIp,
      port: 22,
      username: username,
      passwordOrKey: password,
    );

    try {
      result = await client.connect() ?? 'Null result';
      if (result == "session_connected") {
        debugPrint('SSH connection established.');
        // Wrap the AppleScript in a shell command
        final command = 'osascript -e \'$script\'';
        result = await client.execute(command) ?? 'Null result';
        debugPrint('AppleScript executed successfully: $result');
      }
    } on PlatformException catch (e) {
      String errorMessage = 'Error: ${e.code}\nError Message: ${e.message}';

      result = errorMessage;
      if (printTrace != null) {
        printTrace!(e.message);
      }
      debugPrint('Failed to execute AppleScript via SSH: $e');
    } finally {
      await client.disconnect();
      debugPrint('SSH connection closed.');
    }
  }
}

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basic.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      padding: EdgeInsets.zero,
      tools: const [
        DeviceSection(
          orientation: false,
          virtualKeyboard: false,
          frameVisibility: false,
        ),
        SystemSection(),
        AccessibilitySection(
          accessibleNavigation: false,
          invertColors: false,
          boldText: false,
        ),
        SettingsSection(),
      ],
      builder: (context) => const BasicApp(),
    ),
  );
}

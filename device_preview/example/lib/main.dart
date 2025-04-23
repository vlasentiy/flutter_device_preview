import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basic.dart';

void main() {
  runApp(
    Builder(
      builder: (context) {
        final bottomPadding = MediaQuery.of(context).padding.bottom;
        return DevicePreview(
          enabled: true,
          padding: EdgeInsets.zero,
          safeAreaBottomPadding: bottomPadding,
          builder: (context) => const BasicApp(),
        );
      },
    ),
  );
}

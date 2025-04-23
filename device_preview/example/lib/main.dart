import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basic.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      padding: EdgeInsets.zero,
      builder: (context) => const BasicApp(),
    ),
  );
}

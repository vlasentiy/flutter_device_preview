import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basic.dart';

void main() {
  runApp(
    Builder(
      builder: (context) {
        final bottomPadding = MediaQuery.of(context).padding.bottom;
        bool showOverlay = false;
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return GestureDetector(
              onLongPress: () {
                showOverlay = !showOverlay;
                setState(() {});
              },
              child: DevicePreview(
                enabled: true,
                isToolbarVisible: showOverlay,
                padding: EdgeInsets.zero,
                safeAreaBottomPadding: bottomPadding,
                availableLocales: const [
                  Locale('uk'),
                  Locale('en'),
                  Locale('de'),
                ],
                onEnabledToggle: (p0, state) {
                  print('Enabled: $p0');
                  if (!p0) {
                    //storage?.save(DevicePreviewData(locale: 'uk'));
                    //storage?.load();
                    // state.data = state.data.copyWith(
                    //   isDarkMode: false,
                    //   locale: 'uk',
                    // );
                  }
                },
                onChangeLanguageToggle: (p0) => print('Change language: $p0'),
                builder: (context) => const BasicApp(),
              ),
            );
          },
        );
      },
    ),
  );
}

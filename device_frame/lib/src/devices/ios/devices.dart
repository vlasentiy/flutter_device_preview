import 'dart:ui';

import 'package:device_frame/device_frame.dart';
import 'package:device_frame/src/info/info.dart';

import 'package:device_frame/src/devices/ios/iphone_12_mini/device.dart'
    as i_iphone_12_mini;
import 'package:device_frame/src/devices/ios/iphone_12_pro_max/device.dart'
    as i_iphone_12_pro_max;

import 'package:device_frame/src/devices/ios/iphone_13_mini/device.dart'
    as i_iphone_13_mini;
import 'package:device_frame/src/devices/ios/iphone_13/device.dart'
    as i_iphone_13;
import 'package:device_frame/src/devices/ios/iphone_13_pro_max/device.dart'
    as i_iphone_13_pro_max;

import 'package:device_frame/src/devices/ios/iphone_14_pro/device.dart'
    as i_iphone_14_pro;

import 'package:device_frame/src/devices/ios/iphone_se/device.dart'
    as i_iphone_se;
import 'package:device_frame/src/devices/ios/ipad_air_4/device.dart'
    as i_ipad_air_4;
import 'package:device_frame/src/devices/ios/ipad/device.dart' as i_ipad;
import 'package:device_frame/src/devices/ios/ipad_pro_11inches/device.dart'
    as i_ipad_pro_11inches;
import 'package:device_frame/src/devices/ios/ipad_pro_12Inches_gen2/device.dart'
    as i_ipad_12inches_gen2;
import 'package:device_frame/src/devices/ios/ipad_pro_12Inches_gen4/device.dart'
    as i_ipad_12inches_gen4;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A set of iOS devices.
class IosDevices {
  const IosDevices();

  DeviceInfo get iPhone12Mini => i_iphone_12_mini.info;
  DeviceInfo get iPhone12ProMax => i_iphone_12_pro_max.info;
  DeviceInfo get iPhone13Mini => i_iphone_13_mini.info;
  DeviceInfo get iPhone13 => i_iphone_13.info;
  DeviceInfo get iPhone13ProMax => i_iphone_13_pro_max.info;
  DeviceInfo get iPhone14Pro => i_iphone_14_pro.info;
  DeviceInfo get iPhoneSE => i_iphone_se.info;
  DeviceInfo get iPadAir4 => i_ipad_air_4.info;
  DeviceInfo get iPad => i_ipad.info;
  DeviceInfo get iPadPro11Inches => i_ipad_pro_11inches.info;
  DeviceInfo get iPad12InchesGen2 => i_ipad_12inches_gen2.info;
  DeviceInfo get iPad12InchesGen4 => i_ipad_12inches_gen4.info;

  DeviceInfo get rectangle => _rectangle;
  static final _rectangle = DeviceInfo.genericPhone(
    platform: TargetPlatform.iOS,
    id: 'rectangle',
    name: 'rectangle',
    pixelRatio: 3.0,
    screenSize: const Size(448.0, 998.0),
    safeAreas: const EdgeInsets.only(
      left: 0.0,
      top: 48.0,
      right: 0.0,
      bottom: 0.0,
    ),
    framePainter: const GenericPhoneFramePainter(
      cameraRadius: 0,
      screenRadius: Radius.zero,
      innerBodyRadius: Radius.zero,
      outerBodyRadius: Radius.zero,
    ),
  );

  /// All devices.
  List<DeviceInfo> get all => [
        rectangle,
        // Phones
        iPhone14Pro,
        //iPhone12Mini,
        iPhone12ProMax,
        //iPhone13Mini,
        iPhone13,
        //iPhone13ProMax,
        iPhoneSE,
        // Tablets
        iPadAir4,
        iPad,
        iPadPro11Inches,
      ];
}

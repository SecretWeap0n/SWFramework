import 'package:flutter/material.dart';
import 'package:sw_framework/Responsive/platform_layout.dart';

import 'enums.dart';

class PlatformFunction{
  final Function ios;
  final Function android;
  final Function mobile;
  final Function web;
  static const doNothing=doNothingFunction;
  static doNothingFunction() {}

  PlatformFunction({
    Key? key,
    this.ios=doNothing,
    this.android  =doNothing,
    this.mobile=doNothing,
    this.web=doNothing,
  }) {
    run();
  }


  run() {
    var platform = getPlatform();

    switch (platform) {
      case PlatformType.Web:
        if (web != null) {
          web.call();
        }
        break;
      case PlatformType.Android:
        if (android != null) {
          android.call();
        }
        if (mobile != null) {
          mobile.call();
        }
        if (ios != null) {
          ios.call();
        }
        break;
      case PlatformType.Ios:
        if (ios != null) {
          ios.call();
        }
        if (mobile != null) {
          mobile.call();
        }
        if (android != null) {
          android.call();
        }
        break;
    }
  }
}

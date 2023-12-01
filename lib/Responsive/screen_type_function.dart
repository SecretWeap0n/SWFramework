import 'package:flutter/material.dart';
import 'package:sw_framework/Responsive/UiUtils.dart';
import 'package:sw_framework/Responsive/enums.dart';

class ScreenTypeFunction {
  Function? mobile;
  Function? tablet;
  Function? desktop;
  BuildContext context;

  ScreenTypeFunction({
    required this.context,
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) {
    run();
  }

  run() {
    var mediaquery = MediaQuery.of(
      context,
    );
    var screenType = getDeviceType(mediaquery);

    switch (screenType) {
      case DeviceScreenType.Mobile:
        if (mobile != null) {
          mobile!.call();
          break;
        }
        break;
      case DeviceScreenType.Tablet:
        if (tablet != null) {
          tablet!.call();
          break;
        }
        if (mobile != null) {
          mobile!.call();
          break;
        }
        if (desktop != null) {
          desktop!.call();
          break;
        }
        break;
      case DeviceScreenType.Desktop:
        if (desktop != null) {
          desktop!.call ( );
          break;
        }
        if (tablet != null) {
          tablet!.call ( );
          break;
        }
        if (mobile != null) {
          mobile!.call ( );
          break;
        }
        break;
    }
  }
}

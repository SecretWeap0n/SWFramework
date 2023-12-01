import 'package:flutter/material.dart';

import 'enums.dart';
class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.deviceScreenType=DeviceScreenType.Mobile,
    this.screenSize=const Size(0,0),
    this.localWidgetSize=const Size(0,0),
  });

  @override
  String toString() {
    return 'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}

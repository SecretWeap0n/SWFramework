import 'package:flutter/material.dart';
import 'package:sw_framework/Responsive/responsive_builder.dart';

import 'enums.dart';


class ScreenTypeLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  ScreenTypeLayout({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var deviceScreenType=sizingInformation.deviceScreenType;

        switch(deviceScreenType){
          case DeviceScreenType.Mobile:
            if(mobile!=null){
              return mobile!;
            }
            return Container();
          case DeviceScreenType.Tablet:
            if (tablet != null) {
              return tablet!;
            }
            if (desktop != null) {
              return desktop!;
            }
            return Container();
          case DeviceScreenType.Desktop:
            if (desktop != null) {
              return desktop!;
            }

            if (tablet != null) {
              return tablet!;
            }
            return Container();
        }
      },
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:universal_io/io.dart';

import 'enums.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}

T getValueForPlatform<T>({
  required BuildContext context,
  T? mobile,
  T? desktop,
  T? web,
}) {
  if (Platform.isIOS || Platform.isAndroid) {
    return mobile ?? desktop!;
  } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    return desktop ?? mobile!;
  } else {
    return web ?? mobile!;
  }
}

T getValueForScreenType<T>({
  required BuildContext context,
  T? mobile,
  T? tablet,
  T? desktop,
}) {
  var mediaquery = MediaQuery.of(
    context,
  );
  var screenType = getDeviceType(mediaquery);

  switch (screenType) {
    case DeviceScreenType.Mobile:
      return mobile ?? tablet ?? desktop!;
    case DeviceScreenType.Tablet:
      return tablet ?? mobile ?? desktop!;
    case DeviceScreenType.Desktop:
      return desktop ?? tablet ?? mobile!;
  }
}
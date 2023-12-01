import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
 final Function(BuildContext)? landscape;
 final Function(BuildContext)? portrait;

  OrientationLayout({
    Key? key,
    this.landscape,
    this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        var orientation = MediaQuery.of(context).orientation;
        if (orientation == Orientation.landscape) {
          if (landscape != null) {
            return landscape!(context);
          }
        }

        return portrait!(context);
      },
    );
  }
}

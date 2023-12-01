import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/PlatformProvider.dart';

class SWIconButton extends StatefulWidget {
  final bool enabled;
  final IconData icon;
  final Function onPressed;
  Color? color;

  SWIconButton({Key? key, required this.icon, required this.onPressed, this.color, this.enabled = true})
      : super(key: key);

  @override
  State<SWIconButton> createState() => _SWIconButtonState();
}

class _SWIconButtonState extends State<SWIconButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    var company = context.watch<PlatformProvider>().company;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        if (!widget.enabled) return;
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        if (!widget.enabled) return;
        setState(() {
          isHovered = false;
        });
      },
      child: Card(
        elevation: isHovered ? 5 : 0,
        shape: CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: company.colors.accent,
          ),
          child: IconButton(
              onPressed: () {
                if (widget.enabled) {
                  widget.onPressed();
                }
              },
              padding: EdgeInsets.all(isHovered ? 4 : 0),
              icon: Icon(
                widget.icon,
                color: company.colors.accent.computeLuminance() > 0.3 ? Colors.black : Colors.white,
              )),
        ),
      ),
    );
  }
}

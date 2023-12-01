import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/PlatformProvider.dart';

class SWActionButton extends StatefulWidget {
  final bool enabled;
  final IconData? icon;
  final String label;
  final Function onPressed;
  Color? color;
  bool border;

  SWActionButton(
      {Key? key, this.icon = null, required this.label, required this.onPressed, this.color, this.enabled = true})
      : border = false,
        super(key: key);

  SWActionButton.border(
      {Key? key, this.icon = null, required this.label, required this.onPressed, this.color, this.enabled = true})
      : border = true,
        super(key: key);

  @override
  State<SWActionButton> createState() => _SWActionButtonState();
}

class _SWActionButtonState extends State<SWActionButton> {
  bool isHovered = false;
  Color _color = Colors.transparent;
  Color _foregroundColor = Colors.black;
  Color _textColor = Colors.black;


  void SetColors() {
    var company = context.watch<PlatformProvider>().company;
    _color = !widget.enabled
        ? Colors.grey
        : widget.border
            ? Colors.white
            : widget.color ?? company.colors.accent;
    _foregroundColor = widget.border
        ? company.colors.accent
        : _color.computeLuminance() > 0.3
            ? Colors.black
            : Colors.white;
    _textColor = widget.border
        ? Colors.black
        : _color.computeLuminance() > 0.3
            ? Colors.black
            : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    SetColors();
    return GestureDetector(
      onTap: () {
        if (!widget.enabled) return;
        widget.onPressed();
      },
      child: MouseRegion(
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
          elevation: widget.border
              ? 10
              : isHovered
                  ? 10
                  : 0,
          shadowColor: (widget.border ? Colors.black : _color).withOpacity(isHovered ? 1 : 0),
          color: _color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: 40,
            constraints: BoxConstraints(
              minWidth: 100,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: widget.border ? Border.all(color: _foregroundColor, width: 2) : null,
            ),
            child: AnimatedPadding(
              duration: Duration(milliseconds: 100),
              padding: EdgeInsets.symmetric(horizontal: 8.0 + (isHovered ? 2 : 0), vertical: 5 + (isHovered ? 2 : 0)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null)
                    Row(
                      children: [
                        Icon(
                          widget.icon,
                          color: _foregroundColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  Center(
                    child: Text(
                      widget.label.toUpperCase(),
                      style: TextStyle(
                        color: _textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

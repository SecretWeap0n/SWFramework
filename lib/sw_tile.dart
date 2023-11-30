import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_framework/Models/Company.dart';

import 'Models/QuickAction.dart';
import 'PlatformProvider.dart';

class SWTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget? image;
  final Widget? trailing;
  final Function()? action;

  Color? color;

  List<QuickAction> moreActions = [];

  SWTile({
    Key? key,
    required this.title,
    this.subtitle = "",
    this.action = null,
    this.image = null,
    this.color,
    this.trailing = null,
    this.moreActions = const [],
  }) : super(key: key);

  SWTile.image({
    Key? key,
    required this.title,
    this.subtitle = "",
    this.action = null,
    this.trailing = null,
    this.color,
    required this.image,
    this.moreActions = const [],
  }) : super(key: key);

  @override
  _SWTileState createState() => _SWTileState();
}

class _SWTileState extends State<SWTile> {
  bool isHovered = false;
  Color _textColor = Colors.black;
  Color? backgroundColor = Colors.white;
  late Company company;
  bool menuIsOpen = false;

  @override
  void initState() {
    setCompany();
    super.initState();
  }

  void setCompany() {
    company = context.read<PlatformProvider>().company;
    setStatus(false);
  }

  void setStatus(bool status) {
    setState(() {
      isHovered = status;
      backgroundColor = status
          ? widget.color ?? company.colors.accent
          : Color.lerp(Colors.white, widget.color ?? company.colors.accent, 0.3);
      _textColor = backgroundColor!.computeLuminance() > 0.3 ? Colors.black : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlatformProvider>(builder: (context, provider, child) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setStatus(true);
        },
        onExit: (event) {
          if (menuIsOpen) return;
          setStatus(false);
        },
        child: GestureDetector(
          onTap: () {
            if (widget.action != null) {
              widget.action!();
            }
          },
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Container(
              height: 80,
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Card(
                elevation: isHovered ? 10 : 0,
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      widget.image != null
                          ? Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Center(child: widget.image),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          : const SizedBox(
                              width: 5,
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _textColor,
                            ),
                          ),
                          if (widget.subtitle.isNotEmpty)
                            Text(
                              widget.subtitle,
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: _textColor),
                            ),
                        ],
                      ),
                      const Spacer(),
                      if (widget.trailing != null) widget.trailing!,
                      SizedBox(
                        width: 10,
                      ),
                      if (widget.moreActions.isNotEmpty)
                        widget.moreActions.length < 2
                            ? IconButton(
                                icon: Icon(
                                  widget.moreActions[0].icon,
                                  color: _textColor,
                                ),
                                onPressed: () {
                                  widget.moreActions[0].action();
                                },
                              )
                            : PopupMenuButton(
                                color: company.colors.accent,
                                shadowColor: company.colors.accent,
                                surfaceTintColor: company.colors.accent,
                                //red border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: company.colors.primary,
                                    width: 2,
                                  ),
                                ),
                                elevation: 10,
                                icon: Icon(
                                  Icons.more_vert,
                                  color: _textColor,
                                ),
                                offset: Offset(0, 0),
                                onOpened: () {
                                  setState(() {
                                    menuIsOpen = true;
                                  });
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    setStatus(true);
                                  });
                                },
                                onCanceled: () {
                                  setState(() {
                                    menuIsOpen = false;
                                  });
                                  setStatus(false);
                                },
                                itemBuilder: (context) {
                                  return widget.moreActions.map((key) {
                                    return PopupMenuItem(
                                      value: key,
                                      child: Row(
                                        children: [
                                          Icon(
                                            key.icon,
                                            color: _textColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            key.title,
                                            style: TextStyle(color: _textColor),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList();
                                },
                                onSelected: (value) {
                                  setState(() {
                                    menuIsOpen = false;
                                  });
                                  setStatus(false);
                                  value.action();
                                },
                              ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

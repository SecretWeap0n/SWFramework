import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_framework/Widgets/sw_action_button.dart';

import '../Providers/PlatformProvider.dart';

class SWPopup extends StatelessWidget {
  final String title;
  final Widget content;
  List<SWActionButton> actions = [];
  final SWActionButton defaultAction;

  SWPopup({
    Key? key,
    required this.title,
    required this.content,
    required this.defaultAction,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var company = context.watch<PlatformProvider>().company;
    return AlertDialog(
        elevation: 20,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: company.colors.accent,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.zero, // set padding to zero
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: company.colors.accent.computeLuminance() > 0.3 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: company.colors.primary,
              height: 30,
              thickness: 1,
            )
          ],
        ),
        content: Container(
            constraints: const BoxConstraints(
              minWidth: 500,
            ),
            child: content),
        //TODO: enter hace default action
        actions: [
          ...actions,
          defaultAction,
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Company.dart';
import '../Providers/PlatformProvider.dart';
import '../Providers/SelectedScreenProvider.dart';
import '../Responsive/screen_type_layout.dart';
import 'sw_icon_button.dart';

class SWScreen<T> extends StatefulWidget {
  final String title;
  final Widget actionButton;
  final bool showBackButton;
  final bool showSearchBar;

  final bool hideTitle;
  final Widget Function(BuildContext context, T provider, String searchtext, Company company) builder;

  SWScreen({
    Key? key,
    required this.title,
    required this.builder,
    this.actionButton = const SizedBox.shrink(),
    this.showBackButton = false,
    this.showSearchBar = false,
    this.hideTitle = false,
  }) : super(key: key);

  SWScreen.search({
    Key? key,
    required this.title,
    required this.builder,
    this.actionButton = const SizedBox.shrink(),
    this.showBackButton = false,
    this.hideTitle = false,
  })  : this.showSearchBar = true,
        super(key: key);

  @override
  State<SWScreen<T>> createState() => _SWScreenState<T>();
}

class _SWScreenState<T> extends State<SWScreen<T>> {
  String searchText = "";
  bool showBar = false;
  late Company company;
  final ScrollController _scrollController = ScrollController();

  double scrollOffset = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    company = context.watch<PlatformProvider>().company;
    return Flexible(
      fit: FlexFit.tight,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          appBar: null,
          floatingActionButton: ScreenTypeLayout(
            mobile: widget.actionButton,
            tablet: null,
            desktop: null,
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      //TODO: modify back button
                                      if (widget.showBackButton)
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: company.colors.accent,
                                              ),
                                              child: IconButton(
                                                onPressed: () => {context.read<SelectedScreenProvider>().goBack()},
                                                padding: EdgeInsets.zero, // set padding to zero
                                                icon: Icon(
                                                  Icons.chevron_left,
                                                  color: company.colors.accent.computeLuminance() > 0.3
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      if (!widget.hideTitle)
                                        Flexible(
                                          child: Text(
                                            widget.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.showSearchBar)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        width: showBar ? 300 : 0,
                                        height: 50,
                                        child: AnimatedOpacity(
                                          duration: const Duration(milliseconds: 200),
                                          opacity: showBar ? 1 : 0,
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            onChanged: (text) {
                                              setState(() {
                                                searchText = text;
                                              });
                                            },
                                            onEditingComplete: () {
                                              setState(() {
                                                searchText = "";
                                                showBar = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SWIconButton(
                                          icon: showBar ? Icons.close : Icons.search,
                                          onPressed: () {
                                            setState(() {
                                              showBar = !showBar;
                                              if (!showBar) searchText = "";
                                            });
                                          }),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     color: company.colors.accent,
                                      //   ),
                                      //   child: IconButton(
                                      //       onPressed: () {
                                      //
                                      //       },
                                      //       icon: Icon(
                                      //         showBar ? Icons.close : Icons.search,
                                      //         color: company.colors.accent.computeLuminance() > 0.3
                                      //             ? Colors.black
                                      //             : Colors.white,
                                      //       )),
                                      // ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                          ScreenTypeLayout(
                            mobile: Container(),
                            tablet: widget.actionButton,
                            desktop: widget.actionButton,
                          ),
                        ],
                      ),
                    ),
                    if (scrollOffset > 0)
                      Divider(
                        thickness: 3,
                        height: 3,
                        color: company.colors.accent,
                      ),
                  ],
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          widget.builder(context, Provider.of<T>(context), searchText, company),
                          ScreenTypeLayout(
                            mobile: SizedBox(
                              height: 70,
                            ),
                            tablet: Container(),
                            desktop: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

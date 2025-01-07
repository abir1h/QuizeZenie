import 'package:flutter/material.dart';

import '../../../common/constants/app_theme.dart';

class SearchAppBarScaffold extends StatefulWidget {
  final Widget child;
  final String title;
  final int maxLine;
  final VoidCallback? onReload;
  final WillPopCallback? onBack;
  final Widget? actionChild;
  final Widget? searchChild;
  final Color? bgColor;
  final Widget? floatingActionButton;
  const SearchAppBarScaffold({
    super.key,
    required this.child,
    required this.title,
    this.onReload,
    this.onBack,
    this.actionChild,
    this.searchChild,
    this.maxLine = 2,
    this.bgColor,
    this.floatingActionButton,
  });

  @override
  _SearchAppBarScaffoldState createState() => _SearchAppBarScaffoldState();
}

class _SearchAppBarScaffoldState extends State<SearchAppBarScaffold>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: clr.secondaryBackgroundColor,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: widget.floatingActionButton,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),

            ///Title bar
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _onBackPressed().then((value) {
                      if (value) {
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(left: size.s16) ,
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Icon(
                      Icons.arrow_back,
                      color: clr.iconColorBlack,
                      size: size.s24,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.s8),
                    child: widget.searchChild != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.s20,
                            ),
                            child: widget.searchChild!,
                          )
                        : const Offstage(),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: size.s8),
                //     child: Text(
                //       widget.title,
                //       style: TextStyle(
                //           color: clr.blackColor,
                //           fontSize: size.textLarge,overflow: TextOverflow.ellipsis
                //       ),
                //       maxLines: widget.maxLine,
                //     ),
                //   ),
                // ),
                ///Action child
                if (widget.actionChild != null)
                  GestureDetector(
                    child: widget.actionChild,
                  ),

                ///Reload button
                if (widget.onReload != null)
                  GestureDetector(
                    onTap: widget.onReload,
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.refresh,
                        color: clr.whiteColor,
                        size: size.s24,
                      ),
                    ),
                  ),
              ],
            ),

            ///Search box area
            // if(widget.searchChild != null)Padding(
            //   padding: EdgeInsets.symmetric(horizontal: size.s20,),
            //   child: widget.searchChild!,
            // ),
            SizedBox(
              height: size.s12,
            ),

            ///Body section
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: widget.bgColor ?? clr.backgroundColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(size.s),
                  //   topRight: Radius.circular(size.s24),
                  // )
                ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(size.s24),
                  //   topRight: Radius.circular(size.s24),
                  // ),
                  ///Body
                  child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (widget.onBack != null) {
      return widget.onBack!();
    } else {
      return Future.value(true);
    }
  }
}

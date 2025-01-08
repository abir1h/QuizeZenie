import 'package:co_learning_mobile_app/src/common/constants/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectFolderDropDownVideoRecordScreen<T> extends StatefulWidget {
  final Future<List<T>> Function() onLoadData;
  final String Function(T item) onGenerateTitle;
  final void Function(T item) onSelected;
  final String hintText;
  final String? prefix;
  const SelectFolderDropDownVideoRecordScreen({
    super.key,
    required this.onLoadData,
    required this.onSelected,
    this.hintText = "Select Folder or Category",
    this.prefix,
    required this.onGenerateTitle,
  });

  @override
  State<SelectFolderDropDownVideoRecordScreen<T>> createState() =>
      _SelectFolderDropDownVideoRecordScreenState<T>();
}

class _SelectFolderDropDownVideoRecordScreenState<T>
    extends State<SelectFolderDropDownVideoRecordScreen<T>> with AppTheme {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
  }

  final popupKey = GlobalKey<_VideoPopupWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoPopupWidget(
          key: popupKey,
          child: Container(
            key: GlobalKey(),
            width: double.maxFinite,
            padding:
                EdgeInsets.symmetric(horizontal: size.s16, vertical: size.s8),
            decoration: BoxDecoration(
              color: _selectedItem != null
                  ? widget.onGenerateTitle(_selectedItem as T).isNotEmpty
                      ? clr.appPrimaryColor
                      : clr.dropdownColorGrey
                  : clr.dropdownColorGrey,
              borderRadius: BorderRadius.circular(size.s4),
              border: Border.all(color: clr.textFieldStrokeColor, width: 1.w),
            ),
            child: Container(
              color: _selectedItem != null
                  ? widget.onGenerateTitle(_selectedItem as T).isNotEmpty
                      ? clr.appPrimaryColor
                      : clr.dropdownColorGrey
                  : clr.dropdownColorGrey,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          widget.prefix ?? ImageAssets.folder,
                          height: size.s24,
                          width: size.s24,
                          color: clr.whiteColor,
                        ),
                        size.s4.kWidth,
                        Text(
                          widget.hintText,
                          style: TextStyle(
                              color: clr.whiteColor,
                              fontSize: size.textXXSmall,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: clr.dividerColorGrey,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ),
          popupBuilder: (position, _size, link) {
            return Positioned(
              left: position.dx,
              top: position.dy,
              child: CompositedTransformFollower(
                link: link,
                child: Container(
                  width: _size.width,
                  margin: EdgeInsets.only(top: _size.height + 4.w),
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height -
                          position.dy -
                          8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        blurRadius: 8.w,
                        offset: Offset(0.0, 2.w),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.w),
                    child: FutureBuilder<List<T>>(
                        future: widget.onLoadData(),
                        builder: (context, snapshot) {
                          ///Data state
                          if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty) {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: snapshot.data!
                                        .map(
                                          (m) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  if (mounted) {
                                                    setState(() {
                                                      _selectedItem = m;
                                                    });
                                                  }
                                                  widget.onSelected.call(m);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: size.s16,
                                                      vertical: size.s8),
                                                  width: double.infinity,
                                                  color: Colors.white,
                                                  child: Text(
                                                    widget.onGenerateTitle(m),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: clr.textColorBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 1.2.w,
                                                width: double.infinity,
                                                color: Colors.grey
                                                    .withOpacity(.08),
                                              )
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  size.s32.kHeight
                                ],
                              ),
                            );
                          }

                          ///Empty state
                          else if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isEmpty) {
                            return SizedBox(
                              width: double.maxFinite,
                              height: size.s64,
                              child: const Center(
                                child: Text(
                                  "No item found!",
                                ),
                              ),
                            );
                          }

                          ///Loading state
                          else {
                            return SizedBox(
                              width: double.maxFinite,
                              height: size.s64,
                              child: Center(
                                child: SizedBox(
                                  height: size.s20,
                                  width: size.s20,
                                  child: CircularProgressIndicator(
                                    color: clr.appPrimaryColor,
                                    strokeWidth: 1.6.w,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ),
            );
          },
        ),
        _selectedItem != null
            ? Container(
                margin: EdgeInsets.only(top: size.s8),
                padding: EdgeInsets.symmetric(
                    horizontal: size.s12, vertical: size.s4 + 2),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: clr.borderGray,
                    ),
                    color: clr.whiteColor,
                    borderRadius: BorderRadius.circular(size.s4)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.onGenerateTitle(_selectedItem as T),
                        style: TextStyle(color: clr.appPrimaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        popupKey.currentState?.triggerPopup();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            color: clr.appPrimaryColor,
                            size: size.s12,
                          ),
                          size.s4.kWidth,
                          Text(
                            "Change",
                            style: TextStyle(
                                color: clr.appPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: size.textXXSmall),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
            : Offstage()
      ],
    );
  }
}

class VideoPopupWidget extends StatefulWidget {
  final Widget child;
  final bool Function()? onHitTest;
  final Widget Function(Offset globalPosition, Size size, LayerLink layerLink)
      popupBuilder;

  VideoPopupWidget({
    Key? key,
    required this.child,
    required this.popupBuilder,
    this.onHitTest,
  })  : assert(child.key == null
            ? throw "Popup widget child has no global or local key"
            : true),
        super(key: key);

  final GlobalKey<_VideoPopupWidgetState> popupKey =
      GlobalKey<_VideoPopupWidgetState>();

  @override
  _VideoPopupWidgetState createState() => _VideoPopupWidgetState();
}

class _VideoPopupWidgetState extends State<VideoPopupWidget> {
  final LayerLink _layerLink = LayerLink();

  void triggerPopup() {
    _onWidgetTap(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CompositedTransformTarget(link: _layerLink, child: widget.child),
      onTap: () {
        if (widget.onHitTest == null ||
            (widget.onHitTest != null && widget.onHitTest!())) {
          _onWidgetTap(context);
        }
      },
    );
  }

  void _onWidgetTap(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if ((widget.child.key as GlobalKey).currentContext != null &&
        (widget.child.key as GlobalKey).currentContext?.findRenderObject() !=
            null) {
      final RenderBox renderBox = (widget.child.key as GlobalKey)
          .currentContext!
          .findRenderObject() as RenderBox;
      final size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);
      Widget child = widget.popupBuilder(position, size, _layerLink);
      Navigator.push(context, VideoPopupWidgetModal(child: child));
    }
  }
}

class VideoPopupWidgetModal extends ModalRoute<void> {
  final Widget child;

  VideoPopupWidgetModal({required this.child});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 30);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.white.withOpacity(0);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      onPanStart: (x) {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: <Widget>[child],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

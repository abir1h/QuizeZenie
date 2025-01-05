import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import '../constants/app_theme.dart';
import '../models/page_service.dart';

class SearchBoxWidget extends StatefulWidget {
  final String hintText;
  final void Function(String value) onSearchTermChange;
  final ServiceState serviceState;
  const SearchBoxWidget(
      {super.key,
      required this.hintText,
      required this.onSearchTermChange,
      required this.serviceState});

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> with AppTheme {
  final TextEditingController _textEditingController = TextEditingController();
  late BehaviorSubject<String> _searchSubject;
  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    _searchSubject = BehaviorSubject<String>();
    _subscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen(widget.onSearchTermChange);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _searchSubject.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: size.s42,
      padding: EdgeInsets.symmetric(horizontal: size.s4, vertical: size.s4),
      decoration: BoxDecoration(
        color: clr.whiteColor,
        // border: Border.all(
        //   color: clr.appPrimaryColor,
        //   // width: 1.w,
        // ),
        borderRadius: BorderRadius.circular(size.s4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.0.w),
            child: StreamBuilder<bool>(
                stream: widget.serviceState.searchActivityStream,
                initialData: false,
                builder: (context, snapshot) {
                  if (snapshot.data!) {
                    return SizedBox(
                      height: size.s20,
                      width: size.s20,
                      child: Center(
                        child: SizedBox(
                          height: size.s12,
                          width: size.s12,
                          child: CircularProgressIndicator(
                            color: clr.hintTextColor,
                            strokeWidth: 1.6.w,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Icon(
                      Icons.search_rounded,
                      color: clr.hintTextColor,
                      size: size.s20,
                    );
                  }
                }),
          ),
          SizedBox(
            width: size.s8,
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              maxLines: 1,
              minLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                color: clr.blackText,
                fontSize: size.textSmall,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: clr.blackText,
                  fontSize: size.textSmall,
                ),
              ),
              onChanged: _onTextChange,
            ),
          ),
          if (_textEditingController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _textEditingController.clear();
                _onTextChange(_textEditingController.text);
              },
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  void _onTextChange(String value) {
    if (mounted && !_searchSubject.isClosed) {
      setState(() {
        debugPrint("StateUpdated");
      });
      widget.serviceState.searchTerm = value;
      _searchSubject.add(value);
    }
  }
}

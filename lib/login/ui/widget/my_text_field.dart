import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import '../../../widgets/load_image.dart';

class MyTextField extends StatefulWidget {

  const MyTextField({
    super.key,
    required this.controller,
    this.maxLength = 16,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.isInputPwd = false,
    this.getVCode,
    this.keyName
  });

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode? focusNode;
  final bool isInputPwd;
  final Future<bool> Function()? getVCode;
  final String? keyName;

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    _isShowDelete = widget.controller.text.isNotEmpty;
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  void isEmpty() {
    final bool isNotEmpty = widget.controller.text.isNotEmpty;
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
      [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: widget.hintText,
        hintStyle: TextStyles.textGray14,
        counterText: '',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colours.app_main,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colours.text_gray,
            width: 0.8,
          ),
        ),
      ),
    );

    textField = Listener(
      onPointerDown: (e) => FocusScope.of(context).requestFocus(widget.focusNode),
      child: textField,
    );
    

    Widget? clearButton;

    if (_isShowDelete) {
      clearButton = Semantics(
        child: GestureDetector(
          child: LoadAssetImage('login/delete.png',
            key: Key('${widget.keyName}_delete'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () => widget.controller.text = '',
        ),
      );
    }

    late Widget pwdVisible;
    if (widget.isInputPwd) {
      pwdVisible = Semantics(
        child: GestureDetector(
          child: LoadAssetImage(
            _isShowPwd ? 'login/display.png' : 'login/hide.png',
            key: Key('${widget.keyName}_showPwd'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () {
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      );
    }

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: _isShowDelete,
              child: clearButton ?? Gaps.empty,
            ),
            if (widget.isInputPwd) Gaps.hGap15,
            if (widget.isInputPwd) pwdVisible,
          ],
        )
      ],
    );
  }
}

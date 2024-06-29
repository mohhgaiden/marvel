import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Duration _kWindowDuration = Duration.zero;
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const double _kWindowScreenPadding = 0.001;

Future<T?> showPopupWindow<T>({
  required BuildContext context,
  required RenderBox anchor,
  required Widget child,
  Offset? offset,
  String? semanticLabel,
  bool isShowBg = false,
}) {

  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      semanticLabel ??= MaterialLocalizations.of(context).popupMenuLabel;
  }
  final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;

  final Offset defaultOffset = Offset(0, anchor.size.height);

  if (offset == null) {
    offset = defaultOffset;
  } else {
    offset = offset + defaultOffset;
  }
  final a = anchor.localToGlobal(offset, ancestor: overlay);
  final b = anchor.localToGlobal(anchor.size.bottomLeft(offset), ancestor: overlay);
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(a, b),
    Offset.zero & overlay!.size,
  );
  return Navigator.push(context,
      _PopupWindowRoute(
        position: position,
        child: child,
        semanticLabel: semanticLabel,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        isShowBg: isShowBg
      ));
}

class _PopupWindowRoute<T> extends PopupRoute<T> {
  _PopupWindowRoute({
    super.settings,
    required this.child,
    required this.position,
    required this.barrierLabel,
    required this.semanticLabel,
    required this.isShowBg,
  });

  final Widget child;
  final RelativeRect position;
  final String? semanticLabel;
  final bool isShowBg;
  
  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Duration get transitionDuration => _kWindowDuration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd));
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget win = _PopupWindow<T>(
      route: this,
      semanticLabel: semanticLabel,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: isShowBg ? const Color(0x99000000) : null,
                child: CustomSingleChildLayout(
                  delegate: _PopupWindowLayoutDelegate(
                    position, Directionality.of(context)
                  ),
                  child: win,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PopupWindow<T> extends StatelessWidget {
  const _PopupWindow({
    super.key,
    required this.route,
    required this.semanticLabel,
  });

  final _PopupWindowRoute<T> route;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    const double length = 10.0;
    const double unit = 1.0 /
        (length + 1.5); 

    final CurveTween opacity = CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: const Interval(0.0, unit));
    final CurveTween height = CurveTween(curve: const Interval(0.0, unit * length));

    final Widget child = SingleChildScrollView(
      child: route.child,
    );

    return AnimatedBuilder(
      animation: route.animation!,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: opacity.evaluate(route.animation!),
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            widthFactor: width.evaluate(route.animation!),
            heightFactor: height.evaluate(route.animation!),
            child: Semantics(
              scopesRoute: true,
              namesRoute: true,
              explicitChildNodes: true,
              label: semanticLabel,
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _PopupWindowLayoutDelegate extends SingleChildLayoutDelegate {
  _PopupWindowLayoutDelegate(
      this.position, this.textDirection);

  final RelativeRect position;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest -
        const Offset(_kWindowScreenPadding * 2.0, _kWindowScreenPadding * 2.0) as Size);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {

    double y = position.top;
    double x;
    if (position.left > position.right) {
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      x = position.left;
    } else {
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    if (x < _kWindowScreenPadding) {
      x = _kWindowScreenPadding;
    } else if (x + childSize.width > size.width - _kWindowScreenPadding) {
      x = size.width - childSize.width - _kWindowScreenPadding;
    }

    if (y < _kWindowScreenPadding) {
      y = _kWindowScreenPadding;
    } else if (y + childSize.height > size.height - _kWindowScreenPadding) {
      y = size.height - childSize.height - _kWindowScreenPadding;
    }
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowLayoutDelegate oldDelegate) {
    return position != oldDelegate.position;
  }
}

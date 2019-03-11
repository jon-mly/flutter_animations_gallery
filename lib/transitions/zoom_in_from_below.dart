import 'package:flutter/material.dart';
import 'dart:ui';

class ZoomInFromBelowRouteBuilder extends PageRouteBuilder {
  ZoomInFromBelowRouteBuilder(Widget child, Widget previousChild)
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                ZoomInFromBelowTransition(
                    animation, secondaryAnimation, child, previousChild));
}

class ZoomInFromBelowTransition extends StatefulWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;
  final Widget previousChild;

  ZoomInFromBelowTransition(
      this.animation, this.secondaryAnimation, this.child, this.previousChild);

  @override
  _ZoomInFromBelowTransitionState createState() =>
      _ZoomInFromBelowTransitionState();
}

class _ZoomInFromBelowTransitionState extends State<ZoomInFromBelowTransition> {
  Animation<double> _backgroundScale;
  Animation<Offset> _backgroundOffset;
  Animation<double> _blur;
  Animation<double> _opacity;
  Animation<double> _scale;
  Animation<Offset> _offset;
  Animation<BorderRadius> _radius;

  @override
  void initState() {
    super.initState();

    _backgroundScale =
        Tween<double>(begin: 1.0, end: 1.2).animate(widget.animation);
    _backgroundOffset =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -0.2)).animate(
            CurvedAnimation(parent: widget.animation, curve: Curves.easeInOut));

    _blur = Tween<double>(begin: 0.0, end: 8.0).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Interval(0.2, 1.0, curve: Curves.linear)));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(widget.animation);
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(widget.animation);
    _offset = Tween<Offset>(begin: Offset(0.0, 0.7), end: Offset.zero).animate(
        CurvedAnimation(parent: widget.animation, curve: Curves.easeOut));
    _radius = Tween<BorderRadius>(
            begin: BorderRadius.circular(1.0), end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
            parent: widget.animation, curve: Interval(0.5, 1.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          // Background page animation
          ScaleTransition(
            scale: _backgroundScale,
            child: SlideTransition(
                position: _backgroundOffset, child: widget.previousChild),
          ),
          // Presented page animation
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: _blur.value, sigmaX: _blur.value),
            child: Opacity(
              opacity: _opacity.value,
              child: Container(
                color: Colors.black87.withAlpha(60),
              ),
            ),
          ),
          SlideTransition(
              position: _offset,
              child: ScaleTransition(
                scale: _scale,
                child: ClipRRect(
                  borderRadius:
                      _radius.value * (MediaQuery.of(context).size.width / 7),
                  child: widget.child,
                ),
              ))
        ],
      ),
    );
  }
}

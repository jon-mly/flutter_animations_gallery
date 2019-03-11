import 'package:flutter/material.dart';
import 'dart:ui';

class ZoomOutFromCenterRouteBuilder extends PageRouteBuilder {
  ZoomOutFromCenterRouteBuilder(Widget child, Widget previousChild)
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                ZoomOutFromCenterTransition(
                    animation, secondaryAnimation, child, previousChild));
}

class ZoomOutFromCenterTransition extends StatefulWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;
  final Widget previousChild;

  ZoomOutFromCenterTransition(
      this.animation, this.secondaryAnimation, this.child, this.previousChild);

  @override
  _ZoomOutFromCenterTransitionState createState() =>
      _ZoomOutFromCenterTransitionState();
}

class _ZoomOutFromCenterTransitionState extends State<ZoomOutFromCenterTransition> {
  Animation<double> _backgroundScale;
  Animation<BorderRadius> _backgroundRadius;
  Animation<double> _blur;
  Animation<double> _opacity;
  Animation<double> _scale;
  Animation<BorderRadius> _radius;

  @override
  void initState() {
    super.initState();

    _backgroundScale =
        Tween<double>(begin: 1.0, end: 0.8).animate(widget.animation);
    _backgroundRadius = Tween<BorderRadius>(
        begin: BorderRadius.circular(1.0), end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
        parent: widget.animation, curve: Interval(0.0, 0.5)));

    _blur = Tween<double>(begin: 0.0, end: 8.0).animate(CurvedAnimation(parent: widget.animation, curve: Interval(0.2, 1.0, curve: Curves.linear)));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(widget.animation);
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(widget.animation);
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
          Container(color: Colors.black,),
          // Background page animation
          ScaleTransition(
            scale: _backgroundScale,
            child: ClipRRect(
              borderRadius: _backgroundRadius.value * 20.0,
              child: widget.previousChild,
            )
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
          ScaleTransition(
            scale: _scale,
            child: ClipRRect(
              borderRadius:
              _radius.value * (MediaQuery.of(context).size.width / 7),
              child: widget.child,
            ),
          )
        ],
      ),
    );
  }
}

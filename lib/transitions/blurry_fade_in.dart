import 'package:flutter/material.dart';
import 'dart:ui';

class BlurryFadeInRouteBuilder extends PageRouteBuilder {
  BlurryFadeInRouteBuilder(Widget child, Widget previousChild)
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: 350),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                BlurryFadeInTransition(
                    animation, secondaryAnimation, child, previousChild));
}

class BlurryFadeInTransition extends StatefulWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;
  final Widget previousChild;

  BlurryFadeInTransition(
      this.animation, this.secondaryAnimation, this.child, this.previousChild);

  @override
  _BlurryFadeInTransitionState createState() => _BlurryFadeInTransitionState();
}

class _BlurryFadeInTransitionState extends State<BlurryFadeInTransition> {
  Animation<double> _blurIn;
  Animation<double> _blurOut;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _blurIn = Tween<double>(begin: 0.0, end: 10.0).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn)));
    _blurOut = Tween<double>(begin: 10.0, end: 0.0).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Interval(0.3, 0.7, curve: Curves.easeInOut)));
  }

  @override
  Widget build(BuildContext context) {
    double blurValue =
        widget.animation.value < 0.5 ? _blurIn.value : _blurOut.value;
    bool shouldClearFilter = widget.animation.value >= 1.0;
    return Stack(
      children: <Widget>[
        widget.previousChild,
        Opacity(
          opacity: _opacity.value,
          child: widget.child,
        ),
        // Presented page animation
        (shouldClearFilter)
            ? Container()
            : BackdropFilter(
                filter: ImageFilter.blur(sigmaY: blurValue, sigmaX: blurValue),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
      ],
    );
  }
}

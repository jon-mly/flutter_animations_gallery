import 'package:flutter/material.dart';
import 'dart:ui';

class CircleScaleUpRouteBuilder extends PageRouteBuilder {
  CircleScaleUpRouteBuilder(
      Widget child, Size originalSize, Offset originOffset)
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                CircleScaleUpTransition(animation, secondaryAnimation, child,
                    originalSize, originOffset));
}

class CircleScaleUpTransition extends StatefulWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;
  final Size originalSize;
  final Offset originalOffset;

  CircleScaleUpTransition(this.animation, this.secondaryAnimation, this.child,
      this.originalSize, this.originalOffset);

  @override
  _CircleScaleUpTransitionState createState() =>
      _CircleScaleUpTransitionState();
}

class _CircleScaleUpTransitionState extends State<CircleScaleUpTransition> {
  Animation<double> _scale;
  Animation<double> _offsetProgress;
  Animation<Color> _color;

  @override
  void initState() {
    super.initState();

    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Interval(0.0, 0.9, curve: Curves.easeInOut)));
    _offsetProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animation,
            curve: Interval(0.0, 0.9, curve: Curves.easeInOut)));
    _color = ColorTween(begin: Colors.teal, end: Colors.red).animate(
        CurvedAnimation(parent: widget.animation, curve: Interval(0.0, 0.8)));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animation.value >= 1.0) return widget.child;

    Offset originCenter = Offset(
      widget.originalOffset.dx + widget.originalSize.width / 2,
      widget.originalOffset.dy + widget.originalSize.height / 2,
    );
    Offset pageCenter = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );
    Offset originToCenter = Offset(
        pageCenter.dx - originCenter.dx, pageCenter.dy - originCenter.dy);

    double scale = (widget.originalSize.width +
            _scale.value *
                (MediaQuery.of(context).size.height * 1.3 -
                    widget.originalSize.width)) /
        MediaQuery.of(context).size.width;

    Offset offset = Offset(
      originCenter.dx +
          _offsetProgress.value * originToCenter.dx -
          pageCenter.dx,
      originCenter.dy +
          _offsetProgress.value * originToCenter.dy -
          pageCenter.dy,
    );

    return Transform.translate(
        offset: offset,
        child: Transform.scale(
            scale: scale,
            child: Container(
                decoration: BoxDecoration(
                    color: _color.value, shape: BoxShape.circle))));
  }
}

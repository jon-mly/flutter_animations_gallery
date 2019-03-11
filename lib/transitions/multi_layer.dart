import 'package:flutter/material.dart';

class MultiLayerRouteBuilder extends PageRouteBuilder {
  MultiLayerRouteBuilder(Widget child)
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                MultiLayerTransition(animation, secondaryAnimation, child));
}

class MultiLayerTransition extends StatefulWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  MultiLayerTransition(this.animation, this.secondaryAnimation, this.child);

  @override
  _MultiLayerTransitionState createState() => _MultiLayerTransitionState();
}

class _MultiLayerTransitionState extends State<MultiLayerTransition> {
  Animation<Offset> _firstLayer;
  Animation<Offset> _secondLayer;
  Animation<Offset> _thirdLayer;
  Animation<Offset> _pageLayer;

  @override
  void initState() {
    super.initState();

    _firstLayer = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
            parent: widget.animation,
            curve: Interval(0.0, 0.4, curve: Curves.easeOut)));
    _secondLayer =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(
                parent: widget.animation,
                curve: Interval(0.2, 0.6, curve: Curves.linear)));
    _thirdLayer = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
            parent: widget.animation,
            curve: Interval(0.4, 0.8, curve: Curves.linear)));
    _pageLayer = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
            parent: widget.animation,
            curve: Interval(0.6, 1.0, curve: Curves.easeInOut)));
  }

  Widget _buildLayer(Animation<Offset> animation, Color color) {
    return SlideTransition(position: animation, child: Container(color: color));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLayer(_firstLayer, Colors.greenAccent),
        _buildLayer(_secondLayer, Colors.lime),
        _buildLayer(_thirdLayer, Colors.pinkAccent),
        SlideTransition(position: _pageLayer, child: widget.child),
      ],
    );
  }
}

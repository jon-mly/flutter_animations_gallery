import 'package:flutter/material.dart';
import 'dart:math';

class SliverExamplePage extends StatelessWidget {
  Widget _messageTile(bool isLeft) {
    double leftPadding = (isLeft) ? 8.0 : 150.0;
    double rightPadding = (isLeft) ? 150.0 : 8.0;
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: leftPadding,
        right: rightPadding,
      ),
      child: Text("Lorem Ipsum blah blah blah blah blah blah blah blah blah."),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                _SliverExampleBar("Jonathan Mlynarczyk"),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return _messageTile(index % 2 == 0);
                  }, childCount: 40),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverExampleBar extends StatelessWidget {
  final String _title;

  _SliverExampleBar(this._title);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverExampleBarDelegate(_title),
      pinned: true,
    );
  }
}

class _SliverExampleBarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final TextStyleTween _textStyle = TextStyleTween(
      begin: TextStyle(
          letterSpacing: 5.0, fontWeight: FontWeight.w800, fontSize: 42.0),
      end: TextStyle(
          letterSpacing: 1.0, fontWeight: FontWeight.bold, fontSize: 20.0));
  final Tween<double> _padding = Tween<double>(begin: 30.0, end: 5.0);
  final Tween<double> _opacity = Tween<double>(begin: 1.0, end: 0.0);

  _SliverExampleBarDelegate(this.title);

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 50.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    TextStyle style = _textStyle.lerp(progress);
    double verticalPadding = _padding.lerp(progress);
    double opacity = _opacity.lerp((progress * 3).clamp(0.0, 1.0));

    Widget name = Padding(
        padding:
            EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20.0),
        child: Center(
          child: Text(
            title,
            style: style,
            textAlign: TextAlign.center,
          ),
        ));

    Widget closeButton = Opacity(
      opacity: opacity,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
            onPressed: Navigator.of(context).pop, child: Text("Pop page")),
      ),
    );

    return Container(
      color: Colors.grey,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[name, closeButton],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverExampleBarDelegate oldDelegate) {
    return oldDelegate.title != this.title;
  }
}

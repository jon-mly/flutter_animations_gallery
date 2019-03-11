import 'package:flutter/material.dart';
import 'package:animations_gallery/pages/back_page.dart';
import 'package:animations_gallery/pages/hero_page.dart';
import 'package:animations_gallery/pages/hero_squared_page.dart';
import 'package:animations_gallery/pages/sliver_example_page.dart';
import 'package:animations_gallery/transitions/zoom_in_from_below.dart';
import 'package:animations_gallery/transitions/zoom_out_from_center.dart';
import 'package:animations_gallery/transitions/multi_layer.dart';
import 'package:animations_gallery/transitions/blurry_fade_in.dart';
import 'package:animations_gallery/transitions/circle_scale_up.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<String> _animations = [
    "Circle scale up from position - Transition",
    "Zoom in from below - Transition",
    "Zoom out from center - Transition",
    "Multi layer page reveal - Transition",
    "Blurry fade in - Transition",
    "Simple hero - Hero",
    "Hero with shape change without tween - Hero",
    "Hero with shape change with tween - Hero",
    "Sliver scroll & animated header - Sliver"
  ];

  List<Function> _animationsFunctions;
  List<Widget> _animationsPositionedObjects;

  final GlobalKey _circleZoomInOrigin = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationsFunctions = [
      _presentCircleScaleUpPage,
      _presentZoomInFromBelowPage,
      _presentZoomOutFromBelowPage,
      _presentMultiLayerPageRevealPage,
      _presentBlurryFadePage,
      _presentHeroPage,
      _presentHeroChangingShapeWithoutTweenPage,
      _presentHeroChangingShapeWithTweenPage,
      _presentSliverExample
    ];
    _animationsPositionedObjects = [
      Container(
        key: _circleZoomInOrigin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.teal,
        ),
      ),
      Container(),
      Container(),
      Container(),
      Container(),
      Hero(
        tag: "cirlce_hero",
        child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal)),
      ),
      Hero(
        tag: "cirlce_hero_to_rectangle",
        child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal)),
      ),
      Hero(
        tag: "cirlce_hero_to_rectangle_with_tween",
        child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal)),
      ),
      Container()
    ];
  }

  void _presentZoomInFromBelowPage() {
    Navigator.of(context).push(ZoomInFromBelowRouteBuilder(BackPage(), widget));
  }

  void _presentZoomOutFromBelowPage() {
    Navigator.of(context)
        .push(ZoomOutFromCenterRouteBuilder(BackPage(), widget));
  }

  void _presentMultiLayerPageRevealPage() {
    Navigator.of(context).push(MultiLayerRouteBuilder(BackPage()));
  }

  void _presentBlurryFadePage() {
    Navigator.of(context).push(BlurryFadeInRouteBuilder(BackPage(), widget));
  }

  void _presentCircleScaleUpPage() {
    final RenderBox originContainerRenderBox =
        _circleZoomInOrigin.currentContext.findRenderObject();
    final Size size = originContainerRenderBox.size;
    final Offset absoluteOrigin =
        originContainerRenderBox.localToGlobal(Offset.zero);
    Navigator.of(context)
        .push(CircleScaleUpRouteBuilder(BackPage(), size, absoluteOrigin));
  }

  void _presentHeroPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => HeroPage()));
  }

  void _presentHeroChangingShapeWithoutTweenPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => HeroSquaredPage()));
  }

  void _presentHeroChangingShapeWithTweenPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => HeroSquaredPage()));
  }

  void _presentSliverExample() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => SliverExamplePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations Gallery"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
            itemCount: _animations.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_animations[index]),
                onTap: _animationsFunctions[index],
                trailing: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: Center(
                    child: _animationsPositionedObjects[index],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
